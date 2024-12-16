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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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

  /// Serializes this ChatMessageReaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessageReaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of ChatMessageReaction
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of ChatMessageReaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatMessageCopyWith<$Res> get message {
    return $ChatMessageCopyWith<$Res>(_value.message, (value) {
      return _then(_value.copyWith(message: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChatMessageReactionImplCopyWith<$Res>
    implements $ChatMessageReactionCopyWith<$Res> {
  factory _$$ChatMessageReactionImplCopyWith(_$ChatMessageReactionImpl value,
          $Res Function(_$ChatMessageReactionImpl) then) =
      __$$ChatMessageReactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool seen, ChatMessage message, String reaction, String skinTone});

  @override
  $ChatMessageCopyWith<$Res> get message;
}

/// @nodoc
class __$$ChatMessageReactionImplCopyWithImpl<$Res>
    extends _$ChatMessageReactionCopyWithImpl<$Res, _$ChatMessageReactionImpl>
    implements _$$ChatMessageReactionImplCopyWith<$Res> {
  __$$ChatMessageReactionImplCopyWithImpl(_$ChatMessageReactionImpl _value,
      $Res Function(_$ChatMessageReactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatMessageReaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seen = null,
    Object? message = null,
    Object? reaction = null,
    Object? skinTone = null,
  }) {
    return _then(_$ChatMessageReactionImpl(
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
class _$ChatMessageReactionImpl implements _ChatMessageReaction {
  const _$ChatMessageReactionImpl(
      {this.seen = false,
      required this.message,
      required this.reaction,
      required this.skinTone});

  factory _$ChatMessageReactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageReactionImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageReactionImpl &&
            (identical(other.seen, seen) || other.seen == seen) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.reaction, reaction) ||
                other.reaction == reaction) &&
            (identical(other.skinTone, skinTone) ||
                other.skinTone == skinTone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, seen, message, reaction, skinTone);

  /// Create a copy of ChatMessageReaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageReactionImplCopyWith<_$ChatMessageReactionImpl> get copyWith =>
      __$$ChatMessageReactionImplCopyWithImpl<_$ChatMessageReactionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageReactionImplToJson(
      this,
    );
  }
}

abstract class _ChatMessageReaction implements ChatMessageReaction {
  const factory _ChatMessageReaction(
      {final bool seen,
      required final ChatMessage message,
      required final String reaction,
      required final String skinTone}) = _$ChatMessageReactionImpl;

  factory _ChatMessageReaction.fromJson(Map<String, dynamic> json) =
      _$ChatMessageReactionImpl.fromJson;

  @override
  bool get seen;

  /// The chat message as it looked BEFORE the reaction was added or removed.
  ///
  /// Ie. if the message's reaction map entry for [reaction] contains [fromParticipantId], then that was the state
  /// before this action happened and the user clicked to REMOVE [reaction].
  @override
  ChatMessage get message;

  /// The reaction
  @override
  String get reaction;
  @override
  String get skinTone;

  /// Create a copy of ChatMessageReaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageReactionImplCopyWith<_$ChatMessageReactionImpl> get copyWith =>
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
  @JsonKey(fromJson: reactionsFromJson, includeFromJson: false)
  Map<String, Set<ParticipantId>> get reactions =>
      throw _privateConstructorUsedError;

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {@JsonKey(name: 'fromId') ParticipantId? fromParticipantId,
      @JsonKey(name: 'name') String? fromParticipantName,
      DateTime date,
      DateTime? received,
      String message,
      String? room,
      bool local,
      @JsonKey(fromJson: reactionsFromJson, includeFromJson: false)
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

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$ChatMessageImplCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$ChatMessageImplCopyWith(
          _$ChatMessageImpl value, $Res Function(_$ChatMessageImpl) then) =
      __$$ChatMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'fromId') ParticipantId? fromParticipantId,
      @JsonKey(name: 'name') String? fromParticipantName,
      DateTime date,
      DateTime? received,
      String message,
      String? room,
      bool local,
      @JsonKey(fromJson: reactionsFromJson, includeFromJson: false)
      Map<String, Set<ParticipantId>> reactions});

  @override
  $ParticipantIdCopyWith<$Res>? get fromParticipantId;
}

/// @nodoc
class __$$ChatMessageImplCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$ChatMessageImpl>
    implements _$$ChatMessageImplCopyWith<$Res> {
  __$$ChatMessageImplCopyWithImpl(
      _$ChatMessageImpl _value, $Res Function(_$ChatMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(_$ChatMessageImpl(
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
class _$ChatMessageImpl extends _ChatMessage {
  const _$ChatMessageImpl(
      {@JsonKey(name: 'fromId') this.fromParticipantId,
      @JsonKey(name: 'name') this.fromParticipantName,
      required this.date,
      this.received,
      required this.message,
      this.room,
      this.local = false,
      @JsonKey(fromJson: reactionsFromJson, includeFromJson: false)
      final Map<String, Set<ParticipantId>> reactions = const {}})
      : _reactions = reactions,
        super._();

  factory _$ChatMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageImplFromJson(json);

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
  @JsonKey(fromJson: reactionsFromJson, includeFromJson: false)
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      __$$ChatMessageImplCopyWithImpl<_$ChatMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageImplToJson(
      this,
    );
  }
}

abstract class _ChatMessage extends ChatMessage {
  const factory _ChatMessage(
      {@JsonKey(name: 'fromId') final ParticipantId? fromParticipantId,
      @JsonKey(name: 'name') final String? fromParticipantName,
      required final DateTime date,
      final DateTime? received,
      required final String message,
      final String? room,
      final bool local,
      @JsonKey(fromJson: reactionsFromJson, includeFromJson: false)
      final Map<String, Set<ParticipantId>> reactions}) = _$ChatMessageImpl;
  const _ChatMessage._() : super._();

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$ChatMessageImpl.fromJson;

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
  @JsonKey(fromJson: reactionsFromJson, includeFromJson: false)
  Map<String, Set<ParticipantId>> get reactions;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
