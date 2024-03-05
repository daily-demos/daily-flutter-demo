// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageReactionImpl _$$ChatMessageReactionImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatMessageReactionImpl(
      seen: json['seen'] as bool? ?? false,
      message: ChatMessage.fromJson(json['message'] as Map<String, dynamic>),
      reaction: json['reaction'] as String,
      skinTone: json['skinTone'] as String,
    );

Map<String, dynamic> _$$ChatMessageReactionImplToJson(
        _$ChatMessageReactionImpl instance) =>
    <String, dynamic>{
      'seen': instance.seen,
      'message': instance.message,
      'reaction': instance.reaction,
      'skinTone': instance.skinTone,
    };

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      fromParticipantId: json['fromId'] == null
          ? null
          : ParticipantId.fromJson(json['fromId'] as String),
      fromParticipantName: json['name'] as String?,
      date: DateTime.parse(json['date'] as String),
      received: json['received'] == null
          ? null
          : DateTime.parse(json['received'] as String),
      message: json['message'] as String,
      room: json['room'] as String?,
      local: json['local'] as bool? ?? false,
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'fromId': instance.fromParticipantId,
      'name': instance.fromParticipantName,
      'date': instance.date.toIso8601String(),
      'received': instance.received?.toIso8601String(),
      'message': instance.message,
      'room': instance.room,
      'local': instance.local,
    };
