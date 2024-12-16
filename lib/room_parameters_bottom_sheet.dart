import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

Future<RoomParameters?> showRoomParametersBottomSheet(BuildContext context, Iterable<Uri> roomUrls, String? token) =>
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => RoomParametersBottomSheet(roomUrls: roomUrls, token: token),
    );

class RoomParameters {
  RoomParameters(this.roomUrl, this.token);

  final Uri roomUrl;
  final String? token;
}

class RoomParametersBottomSheet extends StatefulWidget {
  const RoomParametersBottomSheet({super.key, required this.roomUrls, this.token});

  final Iterable<Uri> roomUrls;
  final String? token;

  @override
  State<RoomParametersBottomSheet> createState() => _RoomParametersBottomSheetState();
}

class _RoomParametersBottomSheetState extends State<RoomParametersBottomSheet> {
  bool _canSave = false;

  late Uri? _url = widget.roomUrls.firstOrNull;
  late final _urlController = TextEditingController(text: _url?.toString());
  final _urlFocusNode = FocusNode();

  late String? _token = widget.token;
  late final _tokenController = TextEditingController(text: _token);
  final _tokenFocusNode = FocusNode();

  void _maybeUpdateState() {
    final canSave = _url != null && (_url != widget.roomUrls.firstOrNull || _token != widget.token);
    if (canSave != _canSave) {
      setState(() {
        _canSave = canSave;
      });
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
        if (_url == null && _urlController.text.isEmpty) {
          _urlController.text = 'https://';
        } else {
          _urlController.selection = TextSelection(baseOffset: 0, extentOffset: _urlController.text.length);
        }
      }
    });
    _tokenController.addListener(() {
      _token = _tokenController.text.isEmpty ? null : _tokenController.text;
      _maybeUpdateState();
    });
    _tokenFocusNode.addListener(() {
      if (_tokenFocusNode.hasFocus) {
        _tokenController.selection = TextSelection(baseOffset: 0, extentOffset: _tokenController.text.length);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _urlFocusNode.requestFocus());
  }

  @override
  void dispose() {
    _urlController.dispose();
    _urlFocusNode.dispose();
    _tokenController.dispose();
    _tokenFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 8, 20, MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'https://example.daily.co/room',
                  label: const Text('Room URL'),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: widget.roomUrls.length < 2
                      ? null
                      : Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: PopupMenuButton<Uri>(
                            icon: const Icon(Icons.history),
                            onSelected: (url) => _urlController.text = url.toString(),
                            itemBuilder: (_) => widget.roomUrls
                                .map((url) => PopupMenuItem(value: url, child: Text(url.toString())))
                                .toList(),
                          ),
                        ),
                ),
                keyboardType: TextInputType.url,
                controller: _urlController,
                focusNode: _urlFocusNode,
              ),
              TextField(
                decoration: const InputDecoration(
                  label: Text('Token for private rooms'),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                controller: _tokenController,
                focusNode: _tokenFocusNode,
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
                              Navigator.of(context).pop(RoomParameters(url, _token));
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
