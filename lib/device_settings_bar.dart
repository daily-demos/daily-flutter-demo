import 'dart:async';

import 'package:collection/collection.dart';
import 'package:daily_flutter/daily_flutter.dart';
import 'package:flutter/material.dart';

class DeviceSettingsBar extends StatefulWidget {
  const DeviceSettingsBar({super.key, required this.client});

  final CallClient client;

  @override
  State<DeviceSettingsBar> createState() => _DeviceSettingsBarState();
}

class _DeviceSettingsBarState extends State<DeviceSettingsBar> {
  StreamSubscription? _eventSubscription;
  bool _isCameraEnabled = false;
  bool _isMicrophoneEnabled = false;

  @override
  void initState() {
    super.initState();
    final inputs = widget.client.inputs;
    _isCameraEnabled = inputs.camera.isEnabled;
    _isMicrophoneEnabled = inputs.microphone.isEnabled;
    _eventSubscription = widget.client.events.listen((event) {
      if (!mounted) return;
      event.whenOrNull(
        callStateUpdated: (stateData) {
          // The camera and mic are automatically disabled after a call, set them back to what they were.
          if (stateData.state == CallState.left) {
            widget.client.setInputsEnabled(camera: _isCameraEnabled, microphone: _isMicrophoneEnabled);
          }
        },
        inputsUpdated: (inputs) => setState(() {
          _isCameraEnabled = inputs.camera.isEnabled;
          _isMicrophoneEnabled = inputs.microphone.isEnabled;
        }),
        // Don't need to change any internal state here, just tell Flutter that we want a rebuild.
        publishingUpdated: (publishing) => setState(() {}),
        availableDevicesUpdated: (devices) => setState(() {}),
      );
    });
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 8, right: 4, top: 4, bottom: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).shadowColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onLongPress: () async {
                  final wasPublishing = widget.client.publishing.microphone.isPublishing;
                  await widget.client.toggleMicrophonePublishingEnabled();
                  if (mounted) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(content: Text("Microphone publishing ${wasPublishing ? 'disabled' : 'enabled'}")),
                      );
                  }
                },
                child: IconButton(
                  visualDensity: VisualDensity.compact,
                  color: Theme.of(context).colorScheme.primary,
                  icon: Icon(
                    widget.client.inputs.microphone.isEnabled ? Icons.mic : Icons.mic_off,
                    color: widget.client.publishing.microphone.isPublishing ? null : Colors.red,
                  ),
                  onPressed: widget.client.toggleMicrophoneEnabled,
                ),
              ),
              PopupMenuButton<DeviceId>(
                padding: EdgeInsets.zero,
                icon: Transform.translate(
                  offset: const Offset(-12, 0),
                  child: const Icon(Icons.arrow_drop_down, color: Colors.blue, size: 36),
                ),
                itemBuilder: (_) => (widget.client.availableDevices.microphone)
                    .map((device) => PopupMenuItem(value: device.deviceId, child: Text(device.label)))
                    .toList(),
                onSelected: (id) async {
                  await widget.client.setAudioDevice(deviceId: id);
                  if (!mounted) return;
                  final audioDevice = widget.client.availableDevices.microphone.firstWhereOrNull(
                    (device) => device.deviceId == id,
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text('${audioDevice?.label} selected')));
                },
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onLongPress: () async {
                  final wasPublishing = widget.client.publishing.camera.isPublishing;
                  await widget.client.toggleCameraPublishingEnabled();
                  if (mounted) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(content: Text("Camera publishing ${wasPublishing ? 'disabled' : 'enabled'}")),
                      );
                  }
                },
                child: IconButton(
                  visualDensity: VisualDensity.compact,
                  color: Theme.of(context).colorScheme.primary,
                  icon: Icon(
                    widget.client.inputs.camera.isEnabled ? Icons.videocam : Icons.videocam_off,
                    color: widget.client.publishing.camera.isPublishing ? null : Colors.red,
                  ),
                  onPressed: widget.client.toggleCameraEnabled,
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                color: Theme.of(context).colorScheme.primary,
                icon: const Icon(Icons.flip_camera_ios),
                onPressed: widget.client.inputs.camera.isEnabled ? widget.client.toggleCameraFacingMode : null,
              ),
            ],
          ),
        ),
      );
}
