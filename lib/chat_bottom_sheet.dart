import 'dart:async';
import 'dart:convert';

import 'package:daily_flutter/daily_flutter.dart';
import 'package:daily_flutter_demo/app_message.dart';
import 'package:daily_flutter_demo/chat_message.dart';
import 'package:flutter/material.dart';

void showChatBottomSheet(
  BuildContext context,
  CallClient client,
  ValueNotifier<List<ChatMessage>> messageNotifier,
  VoidCallback onClose,
  final void Function(ChatMessage) onChatMessageSent,
  final void Function(ChatMessageReaction) onChatMessageReactionSent,
) =>
    showModalBottomSheet(
      context: context,
      constraints: BoxConstraints.loose(Size.fromHeight(MediaQuery.of(context).size.height)),
      builder: (_) => ChatBottomSheet(
        client: client,
        messageNotifier: messageNotifier,
        onClose: onClose,
        onChatMessageSent: onChatMessageSent,
        onChatMessageReactionSent: onChatMessageReactionSent,
      ),
    );

class ChatBottomSheet extends StatefulWidget {
  const ChatBottomSheet({
    super.key,
    required this.client,
    required this.messageNotifier,
    required this.onClose,
    required this.onChatMessageSent,
    required this.onChatMessageReactionSent,
  });

  final CallClient client;
  final ValueNotifier<List<ChatMessage>> messageNotifier;
  final VoidCallback onClose;
  final void Function(ChatMessage) onChatMessageSent;
  final void Function(ChatMessageReaction) onChatMessageReactionSent;

  @override
  State<ChatBottomSheet> createState() => _ChatBottomSheetState();
}

class _ChatBottomSheetState extends State<ChatBottomSheet> {
  bool _canSend = false;
  final _textController = TextEditingController();

  late var _messages = widget.messageNotifier.value;

  void _handleNewMessage() {
    if (mounted) setState(() => _messages = widget.messageNotifier.value);
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      final canSend = _textController.text.isNotEmpty;
      if (_canSend != canSend) {
        setState(() => _canSend = canSend);
      }
    });
    widget.messageNotifier.addListener(_handleNewMessage);
  }

  @override
  void dispose() {
    _textController.dispose();
    widget.messageNotifier.removeListener(_handleNewMessage);
    super.dispose();
  }

  Future<ChatMessage> _sendChatMessage({required String message, ParticipantId? recipient}) async {
    final chatMessage = ChatMessage(
      fromParticipantId: widget.client.participants.local.id,
      fromParticipantName: widget.client.participants.local.info.username ?? 'Guest',
      // The backend strips microseconds so we do the same so we can compare the timestamps later.
      date: DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch,
      ).toUtc(),
      message: message,
      local: true,
      room: 'main-room',
    );
    final eventJson = chatMessage.toJson()..['event'] = AppMessageEvent.chatMessage.value;
    await widget.client.sendAppMessage(jsonEncode(eventJson), recipient);
    widget.onChatMessageSent(chatMessage);
    return chatMessage;
  }

  Future<ChatMessageReaction> _sendChatMessageReaction({
    required final ChatMessage message,
    required final String reaction,
    final String? skinTone,
  }) async {
    final chatMessageReaction = ChatMessageReaction(
      message: message,
      reaction: reaction,
      skinTone: skinTone ?? reaction,
    );
    final eventJson = chatMessageReaction.toJson()..['event'] = AppMessageEvent.messageReaction.value;
    await widget.client.sendAppMessage(jsonEncode(eventJson), null);
    widget.onChatMessageReactionSent(chatMessageReaction);
    return chatMessageReaction;
  }

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () {
        unawaited(Future(widget.onClose));
        return Future.value(true);
      },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 0, bottomInsets == 0 ? 12 : bottomInsets),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_messages.isEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  'No messages yet...',
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(height: 8),
              ],
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: _messages.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) {
                    final message = _messages[_messages.length - i - 1];
                    return _MessageBubble(
                      message: message,
                      onReaction: (reaction) => _sendChatMessageReaction(message: message, reaction: reaction),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(hintText: 'Your message here...'),
                      controller: _textController,
                    ),
                  ),
                  IconButton(
                    color: _canSend ? Theme.of(context).colorScheme.primary : Colors.grey,
                    onPressed: _textController.text.isEmpty
                        ? null
                        : () async {
                            await _sendChatMessage(message: _textController.text);
                            if (mounted) {
                              _textController.clear();
                            }
                          },
                    icon: const Icon(Icons.send),
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

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message, required this.onReaction});

  final ChatMessage message;
  final ValueChanged<String> onReaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const borderRadius = Radius.circular(8);
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: 20,
            left: message.local ? 0 : 24,
            right: message.local ? 40 : 16,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(message.local ? .8 : .3),
              borderRadius: BorderRadius.only(
                topLeft: borderRadius,
                topRight: borderRadius,
                bottomLeft: message.local ? Radius.zero : borderRadius,
                bottomRight: message.local ? borderRadius : Radius.zero,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!message.local)
                  Text(
                    message.fromParticipantName ?? '',
                    style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                const SizedBox(height: 4),
                Text(message.message),
              ],
            ),
          ),
        ),
        Positioned(
          left: message.local ? 0 : 24,
          bottom: 0,
          child: _Reactions(reactions: message.reactions, onReaction: onReaction),
        ),
      ],
    );
  }
}

class _Reactions extends StatefulWidget {
  const _Reactions({required this.reactions, required this.onReaction});

  final Map<String, Set<ParticipantId>> reactions;
  final ValueChanged<String> onReaction;

  @override
  State<_Reactions> createState() => _ReactionsState();
}

class _ReactionsState extends State<_Reactions> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          onPressed: () => setState(() => _isExpanded = !_isExpanded),
          iconSize: 16,
          icon: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.add),
          ),
        ),
        if (_isExpanded)
          _ReactionPicker(
            onReaction: (reaction) {
              setState(() => _isExpanded = false);
              widget.onReaction(reaction);
            },
          )
        else if (widget.reactions.values.any((it) => it.isNotEmpty))
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Wrap(
                spacing: 2,
                children: widget.reactions.entries
                    .where((entry) => entry.value.isNotEmpty)
                    .map((entry) => _Reaction(reaction: entry.key, count: entry.value.length))
                    .toList(),
              ),
            ),
          ),
      ],
    );
  }
}

class _Reaction extends StatelessWidget {
  _Reaction({required this.reaction, required this.count}) : super(key: ValueKey(reaction));

  final String reaction;
  final int count;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Text(reaction),
          const SizedBox(width: 2),
          Text(count.toString(), style: Theme.of(context).textTheme.labelSmall),
        ],
      );
}

class _ReactionPicker extends StatelessWidget {
  const _ReactionPicker({required this.onReaction});

  final ValueChanged<String> onReaction;

  // TODO(thomas): This is the actual set of supported reactions but the size causes some UX issues right now.
  //static const reactions = ['❤️', '➕', '🎉', '👋', '👍', '👎', '👏', '🔥', '😂', '🤯'];
  static const reactions = ['❤️', '➕', '🎉', '👍', '👎', '🔥', '😂'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: reactions
            .map(
              (reaction) => InkWell(
                onTap: () => onReaction(reaction),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(reaction),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
