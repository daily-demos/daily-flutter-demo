import 'package:flutter/material.dart';

Future<String?> showUserSettingsBottomSheet(BuildContext context, String? name) =>
    showModalBottomSheet(context: context, builder: (_) => UserSettingsBottomSheet(name: name));

class UserSettingsBottomSheet extends StatefulWidget {
  const UserSettingsBottomSheet({super.key, required this.name});

  final String? name;

  @override
  State<UserSettingsBottomSheet> createState() => _UserSettingsBottomSheetState();
}

class _UserSettingsBottomSheetState extends State<UserSettingsBottomSheet> {
  bool _canSave = false;

  late String? _name = widget.name;
  late final _nameController = TextEditingController(text: _name?.toString());
  late final _nameFocusNode = FocusNode();

  void _maybeUpdateState() {
    final canSave = _name != null && (_name != null && _name != widget.name);
    if (canSave != _canSave) {
      setState(() => _canSave = canSave);
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      _name = _nameController.text.isEmpty ? null : _nameController.text;
      _maybeUpdateState();
    });
    _nameFocusNode.addListener(() {
      if (_nameFocusNode.hasFocus) {
        _nameController.selection = TextSelection(baseOffset: 0, extentOffset: _nameController.text.length);
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
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
                  label: Text('Name'),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                controller: _nameController,
                focusNode: _nameFocusNode,
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
                    onPressed: _canSave ? () => Navigator.of(context).pop(_name) : null,
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
