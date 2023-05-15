// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatMessageReaction _$ChatMessageReactionFromJson(Map<String, dynamic> json) {
  return _ChatMessageReaction.fromJson(json);
}

/// @nodoc
mixin _$ChatMessageReaction {
  bool get seen => throw _privateConstructorUsedError;

  /// The chat message as it looked BEFORE the reaction was added or removed.
  ///
  /// Ie. if the message's reaction map entry for [reaction] contains [fromParticipantId], then that was the state
  /// before this action happened and the user clicked to REMOVE [reaction].
  ChatMessage get message => throw _privateConstructorUsedError;

  /// The reaction
  String get reaction => throw _privateConstructorUsedError;
  String get skinTone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatMessageReactionCopyWith<ChatMessageReaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageReactionCopyWith<$Res> {
  factory $ChatMessageReactionCopyWith(
          ChatMessageReaction value, $Res Function(ChatMessageReaction) then) =
      _$ChatMessageReactionCopyWithImpl<$Res, ChatMessageReaction>;
  @useResult
  $Res call({bool seen, ChatMessage message, String reaction, String skinTone});

  $ChatMessageCopyWith<$Res> get message;
}

/// @nodoc
class _$ChatMessageReactionCopyWithImpl<$Res, $Val extends ChatMessageReaction>
    implements $ChatMessageReactionCopyWith<$Res> {
  _$ChatMessageReactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seen = null,
    Object? message = null,
    Object? reaction = null,
    Object? skinTone = null,
  }) {
    return _then(_value.copyWith(
      seen: null == seen
          ? _value.seen
          : seen // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as ChatMessage,
      reaction: null == reaction
          ? _value.reaction
          : reaction // ignore: cast_nullable_to_non_nullable
              as String,
      skinTone: null == skinTone
          ? _value.skinTone
          : skinTone // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatMessageCopyWith<$Res> get message {
    return $ChatMessageCopyWith<$Res>(_value.message, (value) {
      return _then(_value.copyWith(message: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ChatMessageReactionCopyWith<$Res>
    implements $ChatMessageReactionCopyWith<$Res> {
  factory _$$_ChatMessageReactionCopyWith(_$_ChatMessageReaction value,
          $Res Function(_$_ChatMessageReaction) then) =
      __$$_ChatMessageReactionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool seen, ChatMessage message, String reaction, String skinTone});

  @override
  $ChatMessageCopyWith<$Res> get message;
}

/// @nodoc
class __$$_ChatMessageReactionCopyWithImpl<$Res>
    extends _$ChatMessageReactionCopyWithImpl<$Res, _$_ChatMessageReaction>
    implements _$$_ChatMessageReactionCopyWith<$Res> {
  __$$_ChatMessageReactionCopyWithImpl(_$_ChatMessageReaction _value,
      $Res Function(_$_ChatMessageReaction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seen = null,
    Object? message = null,
    Object? reaction = null,
    Object? skinTone = null,
  }) {
    return _then(_$_ChatMessageReaction(
      seen: null == seen
          ? _value.seen
          : seen // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as ChatMessage,
      reaction: null == reaction
          ? _value.reaction
          : reaction // ignore: cast_nullable_to_non_nullable
              as String,
      skinTone: null == skinTone
          ? _value.skinTone
          : skinTone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatMessageReaction implements _ChatMessageReaction {
  const _$_ChatMessageReaction(
      {this.seen = false,
      required this.message,
      required this.reaction,
      required this.skinTone});

  factory _$_ChatMessageReaction.fromJson(Map<String, dynamic> json) =>
      _$$_ChatMessageReactionFromJson(json);

  @override
  @JsonKey()
  final bool seen;

  /// The chat message as it looked BEFORE the reaction was added or removed.
  ///
  /// Ie. if the message's reaction map entry for [reaction] contains [fromParticipantId], then that was the state
  /// before this action happened and the user clicked to REMOVE [reaction].
  @override
  final ChatMessage message;

  /// The reaction
  @override
  final String reaction;
  @override
  final String skinTone;

  @override
  String toString() {
    return 'ChatMessageReaction(seen: $seen, message: $message, reaction: $reaction, skinTone: $skinTone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatMessageReaction &&
            (identical(other.seen, seen) || other.seen == seen) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.reaction, reaction) ||
                other.reaction == reaction) &&
            (identical(other.skinTone, skinTone) ||
                other.skinTone == skinTone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, seen, message, reaction, skinTone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatMessageReactionCopyWith<_$_ChatMessageReaction> get copyWith =>
      __$$_ChatMessageReactionCopyWithImpl<_$_ChatMessageReaction>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatMessageReactionToJson(
      this,
    );
  }
}

abstract class _ChatMessageReaction implements ChatMessageReaction {
  const factory _ChatMessageReaction(
      {final bool seen,
      required final ChatMessage message,
      required final String reaction,
      required final String skinTone}) = _$_ChatMessageReaction;

  factory _ChatMessageReaction.fromJson(Map<String, dynamic> json) =
      _$_ChatMessageReaction.fromJson;

  @override
  bool get seen;
  @override

  /// The chat message as it looked BEFORE the reaction was added or removed.
  ///
  /// Ie. if the message's reaction map entry for [reaction] contains [fromParticipantId], then that was the state
  /// before this action happened and the user clicked to REMOVE [reaction].
  ChatMessage get message;
  @override

  /// The reaction
  String get reaction;
  @override
  String get skinTone;
  @override
  @JsonKey(ignore: true)
  _$$_ChatMessageReactionCopyWith<_$_ChatMessageReaction> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatMessage {
  @JsonKey(name: 'fromId')
  ParticipantId? get fromParticipantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get fromParticipantName => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  DateTime? get received => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get room => throw _privateConstructorUsedError;
  bool get local => throw _privateConstructorUsedError;
  @JsonKey(fromJson: reactionsFromJson, ignore: true)
  Map<String, Set<ParticipantId>> get reactions =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatMessageCopyWith<ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
          ChatMessage value, $Res Function(ChatMessage) then) =
      _$ChatMessageCopyWithImpl<$Res, ChatMessage>;
  @useResult
  $Res call(
      {@JsonKey(name: 'fromId')
          ParticipantId? fromParticipantId,
      @JsonKey(name: 'name')
          String? fromParticipantName,
      DateTime date,
      DateTime? received,
      String message,
      String? room,
      bool local,
      @JsonKey(fromJson: reactionsFromJson, ignore: true)
          Map<String, Set<ParticipantId>> reactions});

  $ParticipantIdCopyWith<$Res>? get fromParticipantId;
}

/// @nodoc
class _$ChatMessageCopyWithImpl<$Res, $Val extends ChatMessage>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromParticipantId = freezed,
    Object? fromParticipantName = freezed,
    Object? date = null,
    Object? received = freezed,
    Object? message = null,
    Object? room = freezed,
    Object? local = null,
    Object? reactions = null,
  }) {
    return _then(_value.copyWith(
      fromParticipantId: freezed == fromParticipantId
          ? _value.fromParticipantId
          : fromParticipantId // ignore: cast_nullable_to_non_nullable
              as ParticipantId?,
      fromParticipantName: freezed == fromParticipantName
          ? _value.fromParticipantName
          : fromParticipantName // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      received: freezed == received
          ? _value.received
          : received // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      room: freezed == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String?,
      local: null == local
          ? _value.local
          : local // ignore: cast_nullable_to_non_nullable
              as bool,
      reactions: null == reactions
          ? _value.reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as Map<String, Set<ParticipantId>>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ParticipantIdCopyWith<$Res>? get fromParticipantId {
    if (_value.fromParticipantId == null) {
      return null;
    }

    return $ParticipantIdCopyWith<$Res>(_value.fromParticipantId!, (value) {
      return _then(_value.copyWith(fromParticipantId: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ChatMessageCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$_ChatMessageCopyWith(
          _$_ChatMessage value, $Res Function(_$_ChatMessage) then) =
      __$$_ChatMessageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'fromId')
          ParticipantId? fromParticipantId,
      @JsonKey(name: 'name')
          String? fromParticipantName,
      DateTime date,
      DateTime? received,
      String message,
      String? room,
      bool local,
      @JsonKey(fromJson: reactionsFromJson, ignore: true)
          Map<String, Set<ParticipantId>> reactions});

  @override
  $ParticipantIdCopyWith<$Res>? get fromParticipantId;
}

/// @nodoc
class __$$_ChatMessageCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$_ChatMessage>
    implements _$$_ChatMessageCopyWith<$Res> {
  __$$_ChatMessageCopyWithImpl(
      _$_ChatMessage _value, $Res Function(_$_ChatMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromParticipantId = freezed,
    Object? fromParticipantName = freezed,
    Object? date = null,
    Object? received = freezed,
    Object? message = null,
    Object? room = freezed,
    Object? local = null,
    Object? reactions = null,
  }) {
    return _then(_$_ChatMessage(
      fromParticipantId: freezed == fromParticipantId
          ? _value.fromParticipantId
          : fromParticipantId // ignore: cast_nullable_to_non_nullable
              as ParticipantId?,
      fromParticipantName: freezed == fromParticipantName
          ? _value.fromParticipantName
          : fromParticipantName // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      received: freezed == received
          ? _value.received
          : received // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      room: freezed == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String?,
      local: null == local
          ? _value.local
          : local // ignore: cast_nullable_to_non_nullable
              as bool,
      reactions: null == reactions
          ? _value._reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as Map<String, Set<ParticipantId>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatMessage extends _ChatMessage {
  const _$_ChatMessage(
      {@JsonKey(name: 'fromId')
          this.fromParticipantId,
      @JsonKey(name: 'name')
          this.fromParticipantName,
      required this.date,
      this.received,
      required this.message,
      this.room,
      this.local = false,
      @JsonKey(fromJson: reactionsFromJson, ignore: true)
          final Map<String, Set<ParticipantId>> reactions = const {}})
      : _reactions = reactions,
        super._();

  factory _$_ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$$_ChatMessageFromJson(json);

  @override
  @JsonKey(name: 'fromId')
  final ParticipantId? fromParticipantId;
  @override
  @JsonKey(name: 'name')
  final String? fromParticipantName;
  @override
  final DateTime date;
  @override
  final DateTime? received;
  @override
  final String message;
  @override
  final String? room;
  @override
  @JsonKey()
  final bool local;
  final Map<String, Set<ParticipantId>> _reactions;
  @override
  @JsonKey(fromJson: reactionsFromJson, ignore: true)
  Map<String, Set<ParticipantId>> get reactions {
    if (_reactions is EqualUnmodifiableMapView) return _reactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_reactions);
  }

  @override
  String toString() {
    return 'ChatMessage(fromParticipantId: $fromParticipantId, fromParticipantName: $fromParticipantName, date: $date, received: $received, message: $message, room: $room, local: $local, reactions: $reactions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatMessage &&
            (identical(other.fromParticipantId, fromParticipantId) ||
                other.fromParticipantId == fromParticipantId) &&
            (identical(other.fromParticipantName, fromParticipantName) ||
                other.fromParticipantName == fromParticipantName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.received, received) ||
                other.received == received) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.room, room) || other.room == room) &&
            (identical(other.local, local) || other.local == local) &&
            const DeepCollectionEquality()
                .equals(other._reactions, _reactions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      fromParticipantId,
      fromParticipantName,
      date,
      received,
      message,
      room,
      local,
      const DeepCollectionEquality().hash(_reactions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatMessageCopyWith<_$_ChatMessage> get copyWith =>
      __$$_ChatMessageCopyWithImpl<_$_ChatMessage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatMessageToJson(
      this,
    );
  }
}

abstract class _ChatMessage extends ChatMessage {
  const factory _ChatMessage(
      {@JsonKey(name: 'fromId')
          final ParticipantId? fromParticipantId,
      @JsonKey(name: 'name')
          final String? fromParticipantName,
      required final DateTime date,
      final DateTime? received,
      required final String message,
      final String? room,
      final bool local,
      @JsonKey(fromJson: reactionsFromJson, ignore: true)
          final Map<String, Set<ParticipantId>> reactions}) = _$_ChatMessage;
  const _ChatMessage._() : super._();

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$_ChatMessage.fromJson;

  @override
  @JsonKey(name: 'fromId')
  ParticipantId? get fromParticipantId;
  @override
  @JsonKey(name: 'name')
  String? get fromParticipantName;
  @override
  DateTime get date;
  @override
  DateTime? get received;
  @override
  String get message;
  @override
  String? get room;
  @override
  bool get local;
  @override
  @JsonKey(fromJson: reactionsFromJson, ignore: true)
  Map<String, Set<ParticipantId>> get reactions;
  @override
  @JsonKey(ignore: true)
  _$$_ChatMessageCopyWith<_$_ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}
