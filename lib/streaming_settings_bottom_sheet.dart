import 'package:collection/collection.dart';
import 'package:daily_flutter/daily_flutter.dart';
import 'package:flutter/material.dart';

Future<StreamingSettings?> showStreamingSettingsBottomSheet(BuildContext context, LiveStreamEndpoints? endpoints) =>
    showModalBottomSheet(context: context, builder: (_) => StreamingSettingsBottomSheet(endpoints: endpoints));

class StreamingSettingsBottomSheet extends StatefulWidget {
  const StreamingSettingsBottomSheet({super.key, required this.endpoints});

  final LiveStreamEndpoints? endpoints;

  @override
  State<StreamingSettingsBottomSheet> createState() => _StreamingSettingsBottomSheetState();
}

class _StreamingSettingsBottomSheetState extends State<StreamingSettingsBottomSheet> {
  bool _canSave = false;

  late Uri? _url = widget.endpoints?.whenOrNull(rtmpUrls: (urls) => urls.firstOrNull);
  late final _urlController = TextEditingController(text: _url?.toString());
  late final _urlFocusNode = FocusNode();

  void _maybeUpdateState() {
    final canSave = _url != null && (_url != widget.endpoints?.whenOrNull(rtmpUrls: (urls) => urls.firstOrNull));
    if (canSave != _canSave) {
      setState(() => _canSave = canSave);
    }
  }

  @override
  void initState() {
    super.initState();
    _urlController.addListener(() {
      _url = _urlController.text.isEmpty ? null : Uri.tryParse(_urlController.text);
      _maybeUpdateState();
    });
    _urlFocusNode.addListener(() {
      if (_urlFocusNode.hasFocus) {
        _urlController.selection = TextSelection(baseOffset: 0, extentOffset: _urlController.text.length);
      }
    });
  }

  @override
  void dispose() {
    _urlController.dispose();
    _urlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'rtmp://...',
                  label: Text('RTMP URL'),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                keyboardType: TextInputType.url,
                controller: _urlController,
                focusNode: _urlFocusNode,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _canSave
                        ? () {
                            final url = _url;
                            if (url != null) {
                              Navigator.of(context).pop(LiveStreamEndpoints.rtmpUrls(urls: [url]));
                            }
                          }
                        : null,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
