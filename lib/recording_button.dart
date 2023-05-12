import 'dart:async';
import 'dart:convert';

import 'package:daily_flutter/daily_flutter.dart';
import 'package:daily_flutter_demo/streaming_settings_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordingButton extends StatefulWidget {
  const RecordingButton({super.key, required this.client, required this.prefs});

  final CallClient client;
  final SharedPreferences prefs;

  @override
  State<RecordingButton> createState() => _RecordingButtonState();
}

class _RecordingButtonState extends State<RecordingButton> {
  bool _isRecording = false;
  bool _stream = false;

  @override
  void initState() {
    super.initState();
    widget.client.events.listen((event) {
      if (!mounted || !_isRecording) return;
      event.whenOrNull(
        callStateUpdated: (stateData) {
          if (stateData.state != CallState.joined) {
            setState(() => _isRecording = false);
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onLongPress: _isRecording
            ? null
            : () {
                setState(() => _stream = !_stream);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('${_stream ? 'Live streaming' : 'Recording'} mode')));
              },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).shadowColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  if (_isRecording) {
                    if (_stream) {
                      await widget.client.stopLiveStream();
                      messenger
                        ..hideCurrentSnackBar()
                        ..showSnackBar(const SnackBar(content: Text('Live streaming stopped')));
                    } else {
                      await widget.client.stopRecording();
                      messenger
                        ..hideCurrentSnackBar()
                        ..showSnackBar(const SnackBar(content: Text('Recording stopped')));
                    }
                  } else if (_stream) {
                    final endpointsJson = widget.prefs.getString('streamingEndpoints');
                    final endpoints =
                        endpointsJson == null ? null : LiveStreamEndpoints.fromJson(jsonDecode(endpointsJson));
                    final updatedEndpoints = await showModalBottomSheet<LiveStreamEndpoints>(
                      context: context,
                      builder: (_) => StreamingSettingsBottomSheet(endpoints: endpoints),
                    );
                    if (updatedEndpoints == null) return;
                    unawaited(widget.prefs.setString('streamingEndpoints', jsonEncode(updatedEndpoints.toJson())));
                    await widget.client.startLiveStream(endpoints: updatedEndpoints);
                    messenger
                      ..hideCurrentSnackBar()
                      ..showSnackBar(const SnackBar(content: Text('Live streaming started')));
                  } else {
                    await widget.client.startRecording();
                    messenger
                      ..hideCurrentSnackBar()
                      ..showSnackBar(const SnackBar(content: Text('Recording started')));
                  }
                  if (mounted) {
                    setState(() => _isRecording = !_isRecording);
                  }
                },
                icon: AnimatedSwitcher(
                  duration: kThemeAnimationDuration,
                  child: _isRecording
                      ? const Icon(Icons.stop)
                      : _stream
                          ? Transform.translate(
                              offset: const Offset(0, 4),
                              child: Stack(
                                children: [
                                  Transform.translate(
                                    offset: const Offset(0, -10),
                                    child: const Icon(Icons.wifi, color: Colors.red),
                                  ),
                                  const Icon(Icons.fiber_manual_record, color: Colors.red),
                                ],
                              ),
                            )
                          : const Icon(Icons.fiber_manual_record, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      );
}
