import 'package:daily_flutter/daily_flutter.dart';
import 'package:daily_flutter_demo/chat_bottom_sheet.dart';
import 'package:daily_flutter_demo/chat_message.dart';
import 'package:flutter/material.dart';

class ChatButton extends StatefulWidget {
  const ChatButton({
    super.key,
    required this.client,
    required this.messageNotifier,
    required this.onChatMessageSent,
    required this.onChatMessageReactionSent,
  });

  final CallClient client;
  final ValueNotifier<List<ChatMessage>> messageNotifier;

  final void Function(ChatMessage) onChatMessageSent;
  final void Function(ChatMessageReaction) onChatMessageReactionSent;

  @override
  State<ChatButton> createState() => _ChatButtonState();
}

class _ChatButtonState extends State<ChatButton> {
  int _newMessages = 0;
  bool _isBottomSheetOpen = false;

  void _handleNewMessage() {
    if (mounted && !_isBottomSheetOpen) {
      setState(() {
        _newMessages = widget.messageNotifier.value.isEmpty ? 0 : _newMessages + 1;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.messageNotifier.addListener(_handleNewMessage);
  }

  @override
  void dispose() {
    widget.messageNotifier.removeListener(_handleNewMessage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = _newMessages > 99 ? 20.0 : 16.0;
    final theme = Theme.of(context);
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        IconButton(
          onPressed: () {
            showChatBottomSheet(
              context,
              widget.client,
              widget.messageNotifier,
              () {
                if (mounted) {
                  setState(() => _isBottomSheetOpen = false);
                }
              },
              widget.onChatMessageSent,
              widget.onChatMessageReactionSent,
            );
            setState(() {
              _newMessages = 0;
              _isBottomSheetOpen = true;
            });
          },
          icon: Icon(Icons.chat, color: theme.colorScheme.primary),
          visualDensity: VisualDensity.compact,
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          child: _newMessages <= 0
              ? const SizedBox()
              : Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(size / 2),
                  ),
                  child: Center(
                    child: Text(
                      _newMessages > 99 ? '99+' : _newMessages.toString(),
                      style: TextStyle(color: theme.colorScheme.surface, fontSize: 8),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
