// © 2022 Daily, Co. All Rights Reserved

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:daily_flutter/daily_flutter.dart';
import 'package:daily_flutter_demo/app_message.dart';
import 'package:daily_flutter_demo/chat_button.dart';
import 'package:daily_flutter_demo/chat_message.dart';
import 'package:daily_flutter_demo/device_settings_bar.dart';
import 'package:daily_flutter_demo/local_participant_view.dart';
import 'package:daily_flutter_demo/logging.dart';
import 'package:daily_flutter_demo/participant_list_bottom_sheet.dart';
import 'package:daily_flutter_demo/recording_button.dart';
import 'package:daily_flutter_demo/remote_participant_view.dart';
import 'package:daily_flutter_demo/room_settings_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initLogging();
  final client = await CallClient.create();
  runApp(MyApp(prefs: await SharedPreferences.getInstance(), callClient: client));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.prefs, required this.callClient});

  final SharedPreferences prefs;
  final CallClient callClient;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hasActiveCall = false;
  bool _wasCameraEnabled = false;
  bool _wasMicrophoneEnabled = false;
  StreamSubscription? _eventSubscription;
  final _participantFocusPriority = <ParticipantId>[];
  ParticipantId? _activeSpeakerToSet;
  Timer? _setActiveSpeakerTimer;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey();
  final ValueNotifier<List<ChatMessage>> _messageNotifier = ValueNotifier([]);
  final ValueNotifier<List<ParticipantId>> _participantListUpdatedNotifier = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    widget.callClient
      ..setUsername(widget.prefs.getString('username') ?? 'Guest')
      ..updateSubscriptionProfiles(
        forProfiles: {
          SubscriptionProfile.base: const MediaSubscriptionSettingsUpdate.set(
            camera: VideoSubscriptionSettingsUpdate.set(
              subscriptionState: SubscriptionStateUpdate.unsubscribed,
            ),
          ),
          SubscriptionProfile.activeRemote: const MediaSubscriptionSettingsUpdate.set(
            camera: VideoSubscriptionSettingsUpdate.set(
              subscriptionState: SubscriptionStateUpdate.subscribed,
            ),
          ),
        },
      )
      ..setInputsEnabled(camera: true, microphone: true);
    _eventSubscription = widget.callClient.events.listen(_handleEvent);
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    final participantIds = widget.callClient.participants.remote.keys.whereNot(_participantFocusPriority.contains);
    if (!const IterableEquality().equals(participantIds, _participantListUpdatedNotifier.value)) {
      _participantListUpdatedNotifier.value = [...participantIds];
    }
  }

  void _handleEvent(Event event) {
    if (!mounted) return;
    event.whenOrNull<void>(
      callStateUpdated: (callStateData) {
        setState(() {
          final callState = callStateData.state;
          callStateData.whenOrNull(
            joining: () => unawaited(WakelockPlus.toggle(enable: true)),
            joined: (config) {
              final initialUsername = config.initialUserName;
              if (initialUsername != null && initialUsername.isNotEmpty) {
                widget.callClient.setUsername(initialUsername);
              }
              if (!config.initialCameraEnabled || !config.initialMicrophoneEnabled) {
                widget.callClient.updateInputs(
                  inputs: InputSettingsUpdate.set(
                    camera: config.initialCameraEnabled
                        ? null
                        : const CameraInputSettingsUpdate.set(isEnabled: BoolUpdate.set(false)),
                    microphone: config.initialMicrophoneEnabled
                        ? null
                        : const MicrophoneInputSettingsUpdate.set(isEnabled: BoolUpdate.set(false)),
                  ),
                );
              }
            },
            left: () {
              _participantFocusPriority.clear();
              _messageNotifier.value = [];
              // The camera and mic are automatically disabled after a call, set them back to what they were.
              widget.callClient.setInputsEnabled(camera: _wasCameraEnabled, microphone: _wasMicrophoneEnabled);
              unawaited(WakelockPlus.toggle(enable: false));
            },
          );
          _hasActiveCall = callState == CallState.joining || callState == CallState.joined;
        });
      },
      inputsUpdated: (inputs) => setState(() {
        _wasCameraEnabled = inputs.camera.isEnabled;
        _wasMicrophoneEnabled = inputs.microphone.isEnabled;
      }),
      activeSpeakerChanged: (participant) {
        if (!_hasActiveCall ||
            participant == null ||
            participant.info.isLocal ||
            participant.id == _participantFocusPriority.firstOrNull) return;
        _activeSpeakerToSet = participant.id;
        if (_participantFocusPriority.length < 2) {
          _updateActiveSpeaker();
        } else {
          _setActiveSpeakerTimer ??= Timer(const Duration(seconds: 2), _updateActiveSpeaker);
        }
      },
      participantJoined: (participant) {
        if (!_hasActiveCall || participant.info.isLocal || _participantFocusPriority.length >= 3) {
          return;
        }
        setState(() => _participantFocusPriority.add(participant.id));
        _updateSubscriptions();
      },
      participantLeft: (participant) => setState(() {
        _participantFocusPriority.remove(participant.id);
        final participants = widget.callClient.participants;
        if (_participantFocusPriority.length >= min(3, participants.remote.length)) return;
        for (final participantId in participants.remote.keys) {
          if (!_participantFocusPriority.contains(participantId)) {
            _participantFocusPriority.add(participantId);
          }
          if (_participantFocusPriority.length >= 3) break;
        }
        _updateSubscriptions();
      }),
      appMessageReceived: _handleAppMessage,
      error: (error) => _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(content: Text(error))),
    );
  }

  void _updateActiveSpeaker() {
    final activeSpeakerToSet = _activeSpeakerToSet;
    if (mounted && _hasActiveCall && activeSpeakerToSet != null) {
      setState(() {
        _participantFocusPriority
          ..remove(activeSpeakerToSet)
          ..insert(0, activeSpeakerToSet);
        if (_participantFocusPriority.length > 3) {
          _participantFocusPriority.removeRange(3, _participantFocusPriority.length);
        }
      });
    }
    _activeSpeakerToSet = null;
    _setActiveSpeakerTimer = null;
    _updateSubscriptions();
  }

  void _updateSubscriptions() {
    widget.callClient.updateSubscriptions(
      // Profile-wide settings updates are applied before changes to individual participant subscriptions.
      forParticipantsWithProfiles: {
        SubscriptionProfile.activeRemote: const SubscriptionSettingsUpdate.set(
          profile: SubscriptionProfileUpdate.set(profile: SubscriptionProfile.base),
        ),
      },
      forParticipants: {
        for (final id in _participantFocusPriority)
          id: const SubscriptionSettingsUpdate.set(
            profile: SubscriptionProfileUpdate.set(
              profile: SubscriptionProfile.activeRemote,
            ),
          ),
      },
    );
  }

  void _handleAppMessage(final String data, final ParticipantId from) {
    _handleParsedAppMessage(AppMessage.fromJson(jsonDecode(data)), from);
  }

  void _handleParsedAppMessage(final AppMessage data, final ParticipantId from) {
    if (!_hasActiveCall) return;
    data.whenOrNull<void>(
      chatMessage: (message) {
        // Set the participant ID to "from"
        final msg = ChatMessage(
          fromParticipantId: from,
          fromParticipantName: message.fromParticipantName,
          date: message.date,
          received: message.received,
          message: message.message,
          room: message.room,
          local: message.local,
          reactions: message.reactions,
        );
        _messageNotifier.value = [..._messageNotifier.value..add(msg)];
      },
      chatMessageReaction: (reaction) {
        final index = _messageNotifier.value.indexWhere(reaction.message.isSameAs);
        if (index < 0) return;
        final message = _messageNotifier.value.elementAt(index);
        final reactionParticipants = {...message.reactions[reaction.reaction]?.toSet() ?? {}};
        _messageNotifier.value[index] = message.copyWith(
          reactions: {
            ...message.reactions,
            reaction.reaction: reactionParticipants.contains(from)
                ? (reactionParticipants..remove(from))
                : (reactionParticipants..add(from)),
          },
        );
        _messageNotifier.value = [..._messageNotifier.value];
      },
    );
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    widget.callClient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focusedParticipantId = _participantFocusPriority.firstOrNull;
    final nextParticipant1 = _participantFocusPriority.length > 1 ? _participantFocusPriority.elementAt(1) : null;
    final nextParticipant2 = _participantFocusPriority.length > 2 ? _participantFocusPriority.elementAt(2) : null;
    final theme = Theme.of(context);
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      home: CallClientStateProvider(
        callClient: widget.callClient,
        child: Scaffold(
          appBar: AppBar(title: const Text('Daily demo')),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 4, bottom: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DeviceSettingsBar(client: widget.callClient),
                      ],
                    ),
                    Container(
                      alignment: AlignmentDirectional.centerEnd,
                      padding: const EdgeInsetsDirectional.only(end: 20),
                      child: AnimatedSwitcher(
                        duration: kThemeAnimationDuration,
                        transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                        child: widget.callClient.callState != CallState.joined
                            ? const SizedBox()
                            : ChatButton(
                                client: widget.callClient,
                                messageNotifier: _messageNotifier,
                                onChatMessageSent: (chatMessage) => _handleParsedAppMessage(
                                  AppMessage.chatMessage(message: chatMessage),
                                  widget.callClient.participants.local.id,
                                ),
                                onChatMessageReactionSent: (chatMessageReaction) => _handleParsedAppMessage(
                                  AppMessage.chatMessageReaction(reaction: chatMessageReaction),
                                  widget.callClient.participants.local.id,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RecordingButton(client: widget.callClient, prefs: widget.prefs),
                    Expanded(child: RoomSettingsBar(client: widget.callClient, prefs: widget.prefs)),
                  ],
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(children: [LocalParticipantView(client: widget.callClient, prefs: widget.prefs)]),
                if (widget.callClient.callState == CallState.joined && focusedParticipantId == null) ...[
                  const SizedBox(height: 80),
                  const Center(child: Text("There's no one else in this call")),
                ],
                if (focusedParticipantId != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: RemoteParticipantView(
                      client: widget.callClient,
                      participantId: focusedParticipantId,
                      size: const Size.fromHeight(256),
                    ),
                  ),
                if (_participantFocusPriority.length > 1)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (nextParticipant1 != null)
                          RemoteParticipantView(
                            client: widget.callClient,
                            participantId: nextParticipant1,
                            size: const Size.square(128),
                          ),
                        if (nextParticipant2 != null)
                          RemoteParticipantView(
                            client: widget.callClient,
                            participantId: nextParticipant2,
                            size: const Size.square(128),
                          ),
                        if (_participantListUpdatedNotifier.value.isNotEmpty)
                          Builder(
                            builder: (context) {
                              return InkWell(
                                onTap: () {
                                  showParticipantListBottomSheet(
                                    context,
                                    widget.callClient,
                                    _participantListUpdatedNotifier,
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.group, color: theme.colorScheme.primary),
                                    const SizedBox(width: 2),
                                    Text(
                                      '+${_participantListUpdatedNotifier.value.length}',
                                      style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
