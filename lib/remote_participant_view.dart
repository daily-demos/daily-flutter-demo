// © 2022 Daily, Co. All Rights Reserved

import 'dart:async';

import 'package:daily_flutter/daily_flutter.dart';
import 'package:flutter/material.dart';

class RemoteParticipantView extends StatefulWidget {
  const RemoteParticipantView({
    super.key,
    required this.client,
    required this.participantId,
    this.size = const Size.square(160),
  });

  final CallClient client;
  final ParticipantId participantId;
  final Size size;

  @override
  State<RemoteParticipantView> createState() => _RemoteParticipantViewState();
}

class _RemoteParticipantViewState extends State<RemoteParticipantView> {
  String _username = '';
  bool _isCameraMuted = false;
  bool _isMicMuted = false;
  StreamSubscription? _eventSubscription;
  final _controller = VideoViewController();

  @override
  void didUpdateWidget(RemoteParticipantView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _maybeUpdate(widget.client.participants.remote[widget.participantId]);
  }

  @override
  void initState() {
    super.initState();
    _maybeUpdate(widget.client.participants.remote[widget.participantId]);
    _eventSubscription = widget.client.events.listen((event) {
      if (!mounted) return;
      event.whenOrNull<void>(
        subscriptionsUpdated: (_) {
          _maybeUpdate(widget.client.participants.remote[widget.participantId]);
        },
        participantJoined: (participant) async {
          if (participant.id == widget.participantId) {
            _maybeUpdate(participant);
          }
        },
        participantUpdated: (participant) async {
          if (participant.id == widget.participantId) {
            _maybeUpdate(participant);
          }
          if (participant.info.isLocal) {
            setState(() {}); // local canAdmin permission might've changed
          }
        },
      );
    });
  }

  void _maybeUpdate(Participant? participant) => setState(() {
        final username = participant?.info.username;
        _username = username == null || username.isEmpty ? 'Guest' : username;
        _isMicMuted = participant?.isMicrophoneMuted ?? false;
        _isCameraMuted = participant?.isCameraMuted ?? false;
        _updateVideoTrack(participant);
      });

  void _updateVideoTrack(Participant? participant) {
    final ParticipantMedia? media = participant?.media;
    _controller.setTrack(media?.screenVideo.track ?? media?.camera.track);
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final participants = widget.client.participants;
    final participant = participants.all[widget.participantId];

    final permissions = participant?.info.permissions;
    final canSend = permissions?.canSend;
    final canAdmin = permissions?.canAdmin;

    final canSendMic = canSend?.contains(CanSendPermission.microphone) ?? true;
    final canSendCamera = canSend?.contains(CanSendPermission.camera) ?? true;

    final hasPresence = permissions?.hasPresence ?? true;
    final canAdminLiveStreams = canAdmin?.contains(CanAdminPermission.streaming) ?? false;

    final localPermissions = participants.local.info.permissions;
    final localIsParticipantAdmin = localPermissions?.canAdmin.contains(CanAdminPermission.participants) ?? false;
    final localIsOwner = participants.local.info.isOwner;

    final isScreenSharing = participant?.media?.screenVideo.track != null;
    final videoFit = isScreenSharing ? VideoViewFit.contain : VideoViewFit.cover;

    final isMicrophoneOn = participant?.media?.microphone.state != MediaState.off;
    final isCameraOn = participant?.media?.camera.state != MediaState.off;
    final isScreenShareOn = participant?.media?.screenVideo.state != MediaState.off;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.hardEdge,
          width: widget.size.width,
          height: widget.size.height,
          child: _isCameraMuted
              ? const Center(child: Icon(Icons.videocam_off, color: Colors.white))
              : VideoView(controller: _controller, fit: videoFit),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: Colors.black87.withOpacity(.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  if (_isMicMuted) ...const [Icon(Icons.mic_off, color: Colors.grey, size: 16), SizedBox(width: 4)],
                  Text(
                    _username,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (localIsParticipantAdmin)
          Positioned(
            right: 0,
            top: 0,
            child: PopupMenuButton<void Function()>(
              icon: Transform.translate(
                offset: const Offset(8, -8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black87.withOpacity(.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(Icons.more_vert, color: Colors.grey),
                ),
              ),
              padding: EdgeInsets.zero,
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: () => _setParticipantCanSendMic(!canSendMic),
                  child: ListTile(
                    leading: Icon(canSendMic ? Icons.mic_off : Icons.mic),
                    title: Text(canSendMic ? 'Revoke mic' : 'Allow mic'),
                  ),
                ),
                PopupMenuItem(
                  value: () => _setParticipantCanSendCamera(!canSendCamera),
                  child: ListTile(
                    leading: Icon(canSendCamera ? Icons.videocam_off : Icons.videocam),
                    title: Text(canSendCamera ? 'Revoke cam' : 'Allow cam'),
                  ),
                ),
                PopupMenuItem(
                  value: () => _setParticipantHasPresence(!hasPresence),
                  child: ListTile(
                    leading: Icon(hasPresence ? Icons.hide_image : Icons.image),
                    title: Text(hasPresence ? 'Hide' : 'Show'),
                  ),
                ),
                PopupMenuItem(
                  value: () => _setParticipantCanAdminLiveStreams(!canAdminLiveStreams),
                  child: ListTile(
                    leading: Icon(canAdminLiveStreams ? Icons.tv_off : Icons.live_tv),
                    title: Text(canAdminLiveStreams ? 'Demote live stream admin' : 'Make live stream admin'),
                  ),
                ),
                if (isMicrophoneOn)
                  PopupMenuItem(
                    value: () => _setParticipantMicrophoneEnabled(false),
                    child: const ListTile(
                      leading: Icon(Icons.mic_off),
                      title: Text('Mic off'),
                    ),
                  ),
                if (!isMicrophoneOn && localIsOwner)
                  PopupMenuItem(
                    value: () => _setParticipantMicrophoneEnabled(true),
                    child: const ListTile(
                      leading: Icon(Icons.mic),
                      title: Text('Mic on'),
                    ),
                  ),
                if (isCameraOn)
                  PopupMenuItem(
                    value: () => _setParticipantCameraEnabled(false),
                    child: const ListTile(
                      leading: Icon(Icons.mic_off),
                      title: Text('Cam off'),
                    ),
                  ),
                if (isScreenShareOn)
                  PopupMenuItem(
                    value: _disableParticipantScreenShare,
                    child: const ListTile(
                      leading: Icon(Icons.mic_off),
                      title: Text('Screen share off'),
                    ),
                  ),
                if (!isCameraOn && localIsOwner)
                  PopupMenuItem(
                    value: () => _setParticipantCameraEnabled(true),
                    child: const ListTile(
                      leading: Icon(Icons.mic),
                      title: Text('Cam on'),
                    ),
                  ),
              ],
              onSelected: (f) => f(),
            ),
          ),
      ],
    );
  }

  void _setParticipantCanSendMic(bool canSend) {
    final Set<CanSendPermission> permissions = {
      ...widget.client.participants.all[widget.participantId]?.info.permissions?.canSend ?? {},
    };
    if (canSend) {
      permissions
        ..add(CanSendPermission.microphone)
        ..add(CanSendPermission.screenAudio);
    } else {
      permissions
        ..remove(CanSendPermission.microphone)
        ..remove(CanSendPermission.screenAudio);
    }
    widget.client.updateRemoteParticipants(
      updates: RemoteParticipantSettingsUpdatesById.set(
        updates: {
          widget.participantId: RemoteParticipantUpdate.set(
            permissions: ParticipantPermissionsUpdate.set(
              canSend: SetUpdate<CanSendPermission>.set(permissions),
            ),
          ),
        },
      ),
    );
  }

  void _setParticipantCanSendCamera(bool canSend) {
    final Set<CanSendPermission> permissions = {
      ...widget.client.participants.all[widget.participantId]?.info.permissions?.canSend ?? {},
    };
    if (canSend) {
      permissions
        ..add(CanSendPermission.camera)
        ..add(CanSendPermission.screenVideo);
    } else {
      permissions
        ..remove(CanSendPermission.camera)
        ..remove(CanSendPermission.screenVideo);
    }
    widget.client.updateRemoteParticipants(
      updates: RemoteParticipantSettingsUpdatesById.set(
        updates: {
          widget.participantId: RemoteParticipantUpdate.set(
            permissions: ParticipantPermissionsUpdate.set(
              canSend: SetUpdate<CanSendPermission>.set(permissions),
            ),
          ),
        },
      ),
    );
  }

  void _setParticipantHasPresence(bool hasPresence) {
    widget.client.updateRemoteParticipants(
      updates: RemoteParticipantSettingsUpdatesById.set(
        updates: {
          widget.participantId: RemoteParticipantUpdate.set(
            permissions: ParticipantPermissionsUpdate.set(
              hasPresence: BoolUpdate.set(hasPresence),
            ),
          ),
        },
      ),
    );
  }

  void _setParticipantCanAdminLiveStreams(bool canAdminLiveStreams) {
    final Set<CanAdminPermission> permissions = {
      ...widget.client.participants.all[widget.participantId]?.info.permissions?.canAdmin ?? {},
    };
    if (canAdminLiveStreams) {
      permissions.add(CanAdminPermission.streaming);
    } else {
      permissions.remove(CanAdminPermission.streaming);
    }
    widget.client.updateRemoteParticipants(
      updates: RemoteParticipantSettingsUpdatesById.set(
        updates: {
          widget.participantId: RemoteParticipantUpdate.set(
            permissions: ParticipantPermissionsUpdate.set(
              canAdmin: SetUpdate<CanAdminPermission>.set(permissions),
            ),
          ),
        },
      ),
    );
  }

  void _setParticipantMicrophoneEnabled(bool enabled) {
    widget.client.updateRemoteParticipants(
      updates: RemoteParticipantSettingsUpdatesById.set(
        updates: {
          widget.participantId:
              RemoteParticipantUpdate.set(inputsEnabled: RemoteInputsEnabledUpdate.set(microphone: enabled)),
        },
      ),
    );
  }

  void _setParticipantCameraEnabled(bool enabled) {
    widget.client.updateRemoteParticipants(
      updates: RemoteParticipantSettingsUpdatesById.set(
        updates: {
          widget.participantId:
              RemoteParticipantUpdate.set(inputsEnabled: RemoteInputsEnabledUpdate.set(camera: enabled)),
        },
      ),
    );
  }

  void _disableParticipantScreenShare() {
    widget.client.updateRemoteParticipants(
      updates: RemoteParticipantSettingsUpdatesById.set(
        updates: {
          widget.participantId:
              const RemoteParticipantUpdate.set(inputsEnabled: RemoteInputsEnabledUpdate.set(screenShare: false)),
        },
      ),
    );
  }
}
