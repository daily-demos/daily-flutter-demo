// © 2022 Daily, Co. All Rights Reserved

import 'dart:async';

import 'package:daily_flutter/daily_flutter.dart';
import 'package:daily_flutter_demo/user_settings_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalParticipantView extends StatefulWidget {
  const LocalParticipantView({super.key, required this.client, required this.prefs});

  final CallClient client;
  final SharedPreferences prefs;

  @override
  State<LocalParticipantView> createState() => _LocalParticipantViewState();
}

class _LocalParticipantViewState extends State<LocalParticipantView> {
  StreamSubscription? _eventSubscription;
  final _controller = VideoViewController();
  late String _username = widget.client.participants.local.info.username ?? 'Guest';

  @override
  void initState() {
    super.initState();
    _controller.setTrack(widget.client.participants.local.media?.camera.track);
    _eventSubscription = widget.client.events.listen((event) {
      if (!mounted) return;
      event.whenOrNull<void>(
        inputsUpdated: (inputs) {
          _controller
              .setTrack(inputs.camera.isEnabled ? widget.client.participants.local.media?.camera.track : null)
              .whenComplete(() => setState(() {}));
        },
        participantUpdated: (participant) {
          if (!participant.info.isLocal) return;
          _controller
              .setTrack(widget.client.inputs.camera.isEnabled ? participant.media?.camera.track : null)
              .whenComplete(() {
            if (!mounted) return;
            setState(() {
              final username = widget.client.participants.local.info.username;
              _username = username == null || username.isEmpty ? 'Guest' : username;
            });
          });
        },
      );
    });
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final username = await showUserSettingsBottomSheet(context, _username);
        if (!mounted || username == null) return;
        await widget.client.setUsername(username);
        await widget.prefs.setString('username', username);
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.hardEdge,
                child: widget.client.inputs.camera.isEnabled
                    // Showing the local user to themselves as if in a mirror is common practice
                    ? Transform.scale(scaleX: -1, child: VideoView(controller: _controller, fit: VideoViewFit.cover))
                    : const Center(child: Icon(Icons.videocam_off, color: Colors.white)),
              ),
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black87.withOpacity(.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(Icons.more_vert, size: 20, color: Colors.grey),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Container(
                  height: 24,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Colors.black87.withOpacity(.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _username,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
