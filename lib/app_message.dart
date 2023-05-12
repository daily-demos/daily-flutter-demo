// © 2023 Daily, Co. All Rights Reserved

import 'package:daily_flutter/daily_flutter.dart';
import 'package:daily_flutter_demo/chat_message.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_message.freezed.dart';
part 'app_message.g.dart';

enum AppMessageEvent {
  chatMessage('chat-msg'),
  messageReaction('message-reaction');

  const AppMessageEvent(this.value);

  final String value;
}

@Freezed(toJson: true)
class AppMessage with _$AppMessage {
  const factory AppMessage.message({
    required String event,
    required ParticipantId fromParticipantId,
    required Map<String, dynamic> data,
  }) = Message;

  const factory AppMessage.chatMessage({required ChatMessage message}) = _ChatMessage;

  const factory AppMessage.chatMessageReaction({required ChatMessageReaction reaction}) = _ChatMessageReaction;

  factory AppMessage.fromJson(Map<String, dynamic> json) {
    final event = json['event'];
    if (event == 'chat-msg') {
      return AppMessage.chatMessage(message: ChatMessage.fromJson(json));
    }
    if (event == 'message-reaction') {
      return AppMessage.chatMessageReaction(
        // ignore: avoid_dynamic_calls
        reaction: ChatMessageReaction.fromJson(json..['message']['local'] = false),
      );
    }
    return AppMessage.message(
      event: json['event'],
      fromParticipantId: ParticipantId(json['fromId']),
      data: json['msgData'],
    );
  }
}
