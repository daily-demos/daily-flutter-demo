// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppMessage {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String event, ParticipantId fromParticipantId,
            Map<String, dynamic> data)
        message,
    required TResult Function(ChatMessage message) chatMessage,
    required TResult Function(ChatMessageReaction reaction) chatMessageReaction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String event, ParticipantId fromParticipantId,
            Map<String, dynamic> data)?
        message,
    TResult? Function(ChatMessage message)? chatMessage,
    TResult? Function(ChatMessageReaction reaction)? chatMessageReaction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String event, ParticipantId fromParticipantId,
            Map<String, dynamic> data)?
        message,
    TResult Function(ChatMessage message)? chatMessage,
    TResult Function(ChatMessageReaction reaction)? chatMessageReaction,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Message value) message,
    required TResult Function(_ChatMessage value) chatMessage,
    required TResult Function(_ChatMessageReaction value) chatMessageReaction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Message value)? message,
    TResult? Function(_ChatMessage value)? chatMessage,
    TResult? Function(_ChatMessageReaction value)? chatMessageReaction,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Message value)? message,
    TResult Function(_ChatMessage value)? chatMessage,
    TResult Function(_ChatMessageReaction value)? chatMessageReaction,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppMessageCopyWith<$Res> {
  factory $AppMessageCopyWith(
          AppMessage value, $Res Function(AppMessage) then) =
      _$AppMessageCopyWithImpl<$Res, AppMessage>;
}

/// @nodoc
class _$AppMessageCopyWithImpl<$Res, $Val extends AppMessage>
    implements $AppMessageCopyWith<$Res> {
  _$AppMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MessageCopyWith<$Res> {
  factory _$$MessageCopyWith(_$Message value, $Res Function(_$Message) then) =
      __$$MessageCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String event,
      ParticipantId fromParticipantId,
      Map<String, dynamic> data});

  $ParticipantIdCopyWith<$Res> get fromParticipantId;
}

/// @nodoc
class __$$MessageCopyWithImpl<$Res>
    extends _$AppMessageCopyWithImpl<$Res, _$Message>
    implements _$$MessageCopyWith<$Res> {
  __$$MessageCopyWithImpl(_$Message _value, $Res Function(_$Message) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = null,
    Object? fromParticipantId = null,
    Object? data = null,
  }) {
    return _then(_$Message(
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String,
      fromParticipantId: null == fromParticipantId
          ? _value.fromParticipantId
          : fromParticipantId // ignore: cast_nullable_to_non_nullable
              as ParticipantId,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ParticipantIdCopyWith<$Res> get fromParticipantId {
    return $ParticipantIdCopyWith<$Res>(_value.fromParticipantId, (value) {
      return _then(_value.copyWith(fromParticipantId: value));
    });
  }
}

/// @nodoc
@JsonSerializable(createFactory: false)
class _$Message implements Message {
  const _$Message(
      {required this.event,
      required this.fromParticipantId,
      required final Map<String, dynamic> data,
      final String? $type})
      : _data = data,
        $type = $type ?? 'message';

  @override
  final String event;
  @override
  final ParticipantId fromParticipantId;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AppMessage.message(event: $event, fromParticipantId: $fromParticipantId, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Message &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.fromParticipantId, fromParticipantId) ||
                other.fromParticipantId == fromParticipantId) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, event, fromParticipantId,
      const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageCopyWith<_$Message> get copyWith =>
      __$$MessageCopyWithImpl<_$Message>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String event, ParticipantId fromParticipantId,
            Map<String, dynamic> data)
        message,
    required TResult Function(ChatMessage message) chatMessage,
    required TResult Function(ChatMessageReaction reaction) chatMessageReaction,
  }) {
    return message(event, fromParticipantId, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String event, ParticipantId fromParticipantId,
            Map<String, dynamic> data)?
        message,
    TResult? Function(ChatMessage message)? chatMessage,
    TResult? Function(ChatMessageReaction reaction)? chatMessageReaction,
  }) {
    return message?.call(event, fromParticipantId, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String event, ParticipantId fromParticipantId,
            Map<String, dynamic> data)?
        message,
    TResult Function(ChatMessage message)? chatMessage,
    TResult Function(ChatMessageReaction reaction)? chatMessageReaction,
    required TResult orElse(),
  }) {
    if (message != null) {
      return message(event, fromParticipantId, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Message value) message,
    required TResult Function(_ChatMessage value) chatMessage,
    required TResult Function(_ChatMessageReaction value) chatMessageReaction,
  }) {
    return message(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Message value)? message,
    TResult? Function(_ChatMessage value)? chatMessage,
    TResult? Function(_ChatMessageReaction value)? chatMessageReaction,
  }) {
    return message?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Message value)? message,
    TResult Function(_ChatMessage value)? chatMessage,
    TResult Function(_ChatMessageReaction value)? chatMessageReaction,
    required TResult orElse(),
  }) {
    if (message != null) {
      return message(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageToJson(
      this,
    );
  }
}

abstract class Message implements AppMessage {
  const factory Message(
      {required final String event,
      required final ParticipantId fromParticipantId,
      required final Map<String, dynamic> data}) = _$Message;

  String get event;
  ParticipantId get fromParticipantId;
  Map<String, dynamic> get data;
  @JsonKey(ignore: true)
  _$$MessageCopyWith<_$Message> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ChatMessageCopyWith<$Res> {
  factory _$$_ChatMessageCopyWith(
          _$_ChatMessage value, $Res Function(_$_ChatMessage) then) =
      __$$_ChatMessageCopyWithImpl<$Res>;
  @useResult
  $Res call({ChatMessage message});

  $ChatMessageCopyWith<$Res> get message;
}

/// @nodoc
class __$$_ChatMessageCopyWithImpl<$Res>
    extends _$AppMessageCopyWithImpl<$Res, _$_ChatMessage>
    implements _$$_ChatMessageCopyWith<$Res> {
  __$$_ChatMessageCopyWithImpl(
      _$_ChatMessage _value, $Res Function(_$_ChatMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$_ChatMessage(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as ChatMessage,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatMessageCopyWith<$Res> get message {
    return $ChatMessageCopyWith<$Res>(_value.message, (value) {
      return _then(_value.copyWith(message: value));
    });
  }
}

/// @nodoc
@JsonSerializable(createFactory: false)
class _$_ChatMessage implements _ChatMessage {
  const _$_ChatMessage({required this.message, final String? $type})
      : $type = $type ?? 'chatMessage';

  @override
  final ChatMessage message;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AppMessage.chatMessage(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatMessage &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatMessageCopyWith<_$_ChatMessage> get copyWith =>
      __$$_ChatMessageCopyWithImpl<_$_ChatMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String event, ParticipantId fromParticipantId,
            Map<String, dynamic> data)
        message,
    required TResult Function(ChatMessage message) chatMessage,
    required TResult Function(ChatMessageReaction reaction) chatMessageReaction,
  }) {
    return chatMessage(this.message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String event, ParticipantId fromParticipantId,
            Map<String, dynamic> data)?
        message,
    TResult? Function(ChatMessage message)? chatMessage,
    TResult? Function(ChatMessageReaction reaction)? chatMessageReaction,
  }) {
    return chatMessage?.call(this.message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String event, ParticipantId fromParticipantId,
            Map<String, dynamic> data)?
        message,
    TResult Function(ChatMessage message)? chatMessage,
    TResult Function(ChatMessageReaction reaction)? chatMessageReaction,
    required TResult orElse(),
  }) {
    if (chatMessage != null) {
      return chatMessage(this.message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Message value) message,
    required TResult Function(_ChatMessage value) chatMessage,
    required TResult Function(_ChatMessageReaction value) chatMessageReaction,
  }) {
    return chatMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Message value)? message,
    TResult? Function(_ChatMessage value)? chatMessage,
    TResult? Function(_ChatMessageReaction value)? chatMessageReaction,
  }) {
    return chatMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Message value)? message,
    TResult Function(_ChatMessage value)? chatMessage,
    TResult Function(_ChatMessageReaction value)? chatMessageReaction,
    required TResult orElse(),
  }) {
    if (chatMessage != null) {
      return chatMessage(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatMessageToJson(
      this,
    );
  }
}

abstract class _ChatMessage implements AppMessage {
  const factory _ChatMessage({required final ChatMessage message}) =
      _$_ChatMessage;

  ChatMessage get message;
  @JsonKey(ignore: true)
  _$$_ChatMessageCopyWith<_$_ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ChatMessageReactionCopyWith<$Res> {
  factory _$$_ChatMessageReactionCopyWith(_$_ChatMessageReaction value,
          $Res Function(_$_ChatMessageReaction) then) =
      __$$_ChatMessageReactionCopyWithImpl<$Res>;
  @useResult
  $Res call({ChatMessageReaction reaction});

  $ChatMessageReactionCopyWith<$Res> get reaction;
}

/// @nodoc
class __$$_ChatMessageReactionCopyWithImpl<$Res>
    extends _$AppMessageCopyWithImpl<$Res, _$_ChatMessageReaction>
    implements _$$_ChatMessageReactionCopyWith<$Res> {
  __$$_ChatMessageReactionCopyWithImpl(_$_ChatMessageReaction _value,
      $Res Function(_$_ChatMessageReaction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reaction = null,
  }) {
    return _then(_$_ChatMessageReaction(
      reaction: null == reaction
          ? _value.reaction
          : reaction // ignore: cast_nullable_to_non_nullable
              as ChatMessageReaction,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatMessageReactionCopyWith<$Res> get reaction {
    return $ChatMessageReactionCopyWith<$Res>(_value.reaction, (value) {
      return _then(_value.copyWith(reaction: value));
    });
  }
}

/// @nodoc
@JsonSerializable(createFactory: false)
class _$_ChatMessageReaction implements _ChatMessageReaction {
  const _$_ChatMessageReaction({required this.reaction, final String? $type})
      : $type = $type ?? 'chatMessageReaction';

  @override
  final ChatMessageReaction reaction;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AppMessage.chatMessageReaction(reaction: $reaction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatMessageReaction &&
            (identical(other.reaction, reaction) ||
                other.reaction == reaction));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, reaction);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatMessageReactionCopyWith<_$_ChatMessageReaction> get copyWith =>
      __$$_ChatMessageReactionCopyWithImpl<_$_ChatMessageReaction>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String event, ParticipantId fromParticipantId,
            Map<String, dynamic> data)
        message,
    required TResult Function(ChatMessage message) chatMessage,
    required TResult Function(ChatMessageReaction reaction) chatMessageReaction,
  }) {
    return chatMessageReaction(reaction);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String event, ParticipantId fromParticipantId,
            Map<String, dynamic> data)?
        message,
    TResult? Function(ChatMessage message)? chatMessage,
    TResult? Function(ChatMessageReaction reaction)? chatMessageReaction,
  }) {
    return chatMessageReaction?.call(reaction);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String event, ParticipantId fromParticipantId,
            Map<String, dynamic> data)?
        message,
    TResult Function(ChatMessage message)? chatMessage,
    TResult Function(ChatMessageReaction reaction)? chatMessageReaction,
    required TResult orElse(),
  }) {
    if (chatMessageReaction != null) {
      return chatMessageReaction(reaction);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Message value) message,
    required TResult Function(_ChatMessage value) chatMessage,
    required TResult Function(_ChatMessageReaction value) chatMessageReaction,
  }) {
    return chatMessageReaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Message value)? message,
    TResult? Function(_ChatMessage value)? chatMessage,
    TResult? Function(_ChatMessageReaction value)? chatMessageReaction,
  }) {
    return chatMessageReaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Message value)? message,
    TResult Function(_ChatMessage value)? chatMessage,
    TResult Function(_ChatMessageReaction value)? chatMessageReaction,
    required TResult orElse(),
  }) {
    if (chatMessageReaction != null) {
      return chatMessageReaction(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatMessageReactionToJson(
      this,
    );
  }
}

abstract class _ChatMessageReaction implements AppMessage {
  const factory _ChatMessageReaction(
      {required final ChatMessageReaction reaction}) = _$_ChatMessageReaction;

  ChatMessageReaction get reaction;
  @JsonKey(ignore: true)
  _$$_ChatMessageReactionCopyWith<_$_ChatMessageReaction> get copyWith =>
      throw _privateConstructorUsedError;
}
