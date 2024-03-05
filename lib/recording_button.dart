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
  bool _isStreamingOrRecording = false;
  bool _isInStreamingMode = false;

  void _showSnackBar(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  void initState() {
    super.initState();
    widget.client.events.listen((event) {
      if (!mounted) return;
      event.whenOrNull(
        callStateUpdated: (stateData) {
          setState(() {
            if (stateData.state != CallState.joined) {
              _isStreamingOrRecording = false;
            }
          });
        },
        recordingStarted: (_) {
          setState(() {
            _isStreamingOrRecording = true;
            _isInStreamingMode = false;
          });
          _showSnackBar('Recording started');
        },
        recordingStopped: (_) {
          setState(() {
            _isStreamingOrRecording = false;
            _isInStreamingMode = false;
          });
          _showSnackBar('Recording stopped');
        },
        recordingError: (_, __) {
          setState(() {
            _isStreamingOrRecording = false;
            _isInStreamingMode = false;
          });
          _showSnackBar('Recording stopped');
        },
        liveStreamStarted: (_) {
          setState(() {
            _isStreamingOrRecording = true;
            _isInStreamingMode = true;
          });
          _showSnackBar('Live streaming started');
        },
        liveStreamStopped: (_) {
          setState(() {
            _isStreamingOrRecording = false;
            _isInStreamingMode = true;
          });
          _showSnackBar('Live streaming stopped');
        },
        liveStreamError: (_, __) {
          setState(() {
            _isStreamingOrRecording = false;
            _isInStreamingMode = true;
          });
          _showSnackBar('Live streaming stopped');
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
        duration: kThemeAnimationDuration,
        transitionBuilder: (child, animation) => SizeTransition(
          axisAlignment: -1,
          sizeFactor: animation,
          axis: Axis.horizontal,
          child: child,
        ),
        child: widget.client.callState != CallState.joined
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsetsDirectional.only(end: 4),
                child: GestureDetector(
                  onLongPress: _isStreamingOrRecording
                      ? null
                      : () {
                          setState(() => _isInStreamingMode = !_isInStreamingMode);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${_isInStreamingMode ? 'Live streaming' : 'Recording'} mode')),
                          );
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
                          onPressed: _onPressed,
                          icon: AnimatedSwitcher(
                            duration: kThemeAnimationDuration,
                            child: _isStreamingOrRecording
                                ? const Icon(Icons.stop)
                                : _isInStreamingMode
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
                ),
              ),
      );

  Future<void> _onPressed() async {
    if (_isStreamingOrRecording) {
      if (_isInStreamingMode) {
        await widget.client.stopLiveStream();
      } else {
        await widget.client.stopRecording();
      }
    } else if (_isInStreamingMode) {
      final endpointsJson = widget.prefs.getString('streamingEndpoints');
      final endpoints = endpointsJson == null ? null : LiveStreamEndpoints.fromJson(jsonDecode(endpointsJson));
      final updatedEndpoints = await showModalBottomSheet<LiveStreamEndpoints>(
        context: context,
        builder: (_) => StreamingSettingsBottomSheet(endpoints: endpoints),
      );
      if (updatedEndpoints == null) return;
      unawaited(widget.prefs.setString('streamingEndpoints', jsonEncode(updatedEndpoints.toJson())));
      await widget.client.startLiveStream(endpoints: updatedEndpoints);
    } else {
      await widget.client.startRecording();
    }
  }
}
