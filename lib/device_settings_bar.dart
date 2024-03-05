import 'package:collection/collection.dart';
import 'package:daily_flutter/daily_flutter.dart';
import 'package:flutter/material.dart';

class DeviceSettingsBar extends StatelessWidget {
  const DeviceSettingsBar({super.key, required this.client});

  final CallClient client;

  Future<void> toggleMicrophonePublishingEnabled() =>
      client.setIsPublishing(microphone: !client.publishing.microphone.isPublishing);

  Future<void> toggleCameraPublishingEnabled() =>
      client.setIsPublishing(camera: !client.publishing.camera.isPublishing);

  Future<void> toggleMicrophoneEnabled() => client.setInputsEnabled(microphone: !client.inputs.microphone.isEnabled);

  Future<void> toggleCameraEnabled() => client.setInputsEnabled(camera: !client.inputs.camera.isEnabled);

  Future<void> toggleCameraFacingMode() =>
      client.setCameraFacingMode(facingMode: client.inputs.camera.settings.facingMode.flipped);

  @override
  Widget build(BuildContext context) {
    final publishing = CallClientState.publishingOf(context);
    final inputs = CallClientState.inputsOf(context);
    return Container(
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
                final wasPublishing = client.publishing.microphone.isPublishing;
                final messenger = ScaffoldMessenger.of(context);
                await toggleMicrophonePublishingEnabled();
                messenger
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text("Microphone publishing ${wasPublishing ? 'disabled' : 'enabled'}")),
                  );
              },
              child: IconButton(
                visualDensity: VisualDensity.compact,
                color: Theme.of(context).colorScheme.primary,
                icon: Icon(
                  inputs.microphone.isEnabled ? Icons.mic : Icons.mic_off,
                  color: publishing.microphone.isPublishing ? null : Colors.red,
                ),
                onPressed: toggleMicrophoneEnabled,
              ),
            ),
            PopupMenuButton<DeviceId>(
              padding: EdgeInsets.zero,
              icon: Transform.translate(
                offset: const Offset(-12, 0),
                child: const Icon(Icons.arrow_drop_down, color: Colors.blue, size: 36),
              ),
              itemBuilder: (_) => CallClientState.availableDevicesOf(context)
                  .microphone
                  .map((device) => PopupMenuItem(value: device.deviceId, child: Text(device.label)))
                  .toList(),
              onSelected: (id) async {
                final messenger = ScaffoldMessenger.of(context);
                await client.setAudioDevice(deviceId: id);
                final audioDevice = client.availableDevices.microphone.firstWhereOrNull(
                  (device) => device.deviceId == id,
                );
                messenger
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text('${audioDevice?.label} selected')));
              },
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onLongPress: () async {
                final wasPublishing = client.publishing.camera.isPublishing;
                final messenger = ScaffoldMessenger.of(context);
                await toggleCameraPublishingEnabled();
                messenger
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text("Camera publishing ${wasPublishing ? 'disabled' : 'enabled'}")),
                  );
              },
              child: IconButton(
                visualDensity: VisualDensity.compact,
                color: Theme.of(context).colorScheme.primary,
                icon: Icon(
                  inputs.camera.isEnabled ? Icons.videocam : Icons.videocam_off,
                  color: publishing.camera.isPublishing ? null : Colors.red,
                ),
                onPressed: toggleCameraEnabled,
              ),
            ),
            IconButton(
              visualDensity: VisualDensity.compact,
              color: Theme.of(context).colorScheme.primary,
              icon: const Icon(Icons.flip_camera_ios),
              onPressed: client.inputs.camera.isEnabled ? toggleCameraFacingMode : null,
            ),
          ],
        ),
      ),
    );
  }
}
