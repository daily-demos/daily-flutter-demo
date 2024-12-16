// © 2023 Daily, Co. All Rights Reserved

// ignore_for_file: invalid_annotation_target

import 'package:daily_flutter/daily_flutter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

/// Describes an event where a user has clicked or tapped a reaction button, whether to add or remove it.
@freezed
class ChatMessageReaction with _$ChatMessageReaction {
  const factory ChatMessageReaction({
    @Default(false) bool seen,

    /// The chat message as it looked BEFORE the reaction was added or removed.
    ///
    /// Ie. if the message's reaction map entry for [reaction] contains [fromParticipantId], then that was the state
    /// before this action happened and the user clicked to REMOVE [reaction].
    required ChatMessage message,

    /// The reaction
    required String reaction,
    required String skinTone,
  }) = _ChatMessageReaction;

  factory ChatMessageReaction.fromJson(Map<String, dynamic> json) => _$ChatMessageReactionFromJson(json);
}

Map<String, List<ParticipantId>> reactionsFromJson(Map<String, dynamic> json) => json.map((key, value) {
      // ignore: avoid_as
      final participants = (value is Map ? value.values.expand((e) => e) : value) as Iterable;
      return MapEntry(key, participants.cast<String>().map(ParticipantId.fromJson).toList());
    });

DateTime dateTimeFromJson(String dateTimeStr) => DateTime.parse(dateTimeStr).toLocal();

/// Describes a chat message from a user
@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    @JsonKey(name: 'fromId') ParticipantId? fromParticipantId,
    @JsonKey(name: 'name') String? fromParticipantName,
    required DateTime date,
    DateTime? received,
    required String message,
    String? room,
    @Default(false) bool local,
    @JsonKey(fromJson: reactionsFromJson, includeFromJson: false)
    @Default({})
    Map<String, Set<ParticipantId>> reactions,
  }) = _ChatMessage;

  const ChatMessage._();

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);

  bool get hasReactions => reactions.values.any((it) => it.isNotEmpty);

  bool isSameAs(ChatMessage other) =>
      fromParticipantId == other.fromParticipantId && date == other.date && message == other.message;
}
