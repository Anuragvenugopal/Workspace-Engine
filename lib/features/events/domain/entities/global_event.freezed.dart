// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'global_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GlobalEvent {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get thumbnailUrl => throw _privateConstructorUsedError;
  DateTime get eventDate => throw _privateConstructorUsedError;

  /// Create a copy of GlobalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GlobalEventCopyWith<GlobalEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GlobalEventCopyWith<$Res> {
  factory $GlobalEventCopyWith(
    GlobalEvent value,
    $Res Function(GlobalEvent) then,
  ) = _$GlobalEventCopyWithImpl<$Res, GlobalEvent>;
  @useResult
  $Res call({
    int id,
    String title,
    String description,
    String imageUrl,
    String thumbnailUrl,
    DateTime eventDate,
  });
}

/// @nodoc
class _$GlobalEventCopyWithImpl<$Res, $Val extends GlobalEvent>
    implements $GlobalEventCopyWith<$Res> {
  _$GlobalEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GlobalEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? thumbnailUrl = null,
    Object? eventDate = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            thumbnailUrl: null == thumbnailUrl
                ? _value.thumbnailUrl
                : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            eventDate: null == eventDate
                ? _value.eventDate
                : eventDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GlobalEventImplCopyWith<$Res>
    implements $GlobalEventCopyWith<$Res> {
  factory _$$GlobalEventImplCopyWith(
    _$GlobalEventImpl value,
    $Res Function(_$GlobalEventImpl) then,
  ) = __$$GlobalEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String title,
    String description,
    String imageUrl,
    String thumbnailUrl,
    DateTime eventDate,
  });
}

/// @nodoc
class __$$GlobalEventImplCopyWithImpl<$Res>
    extends _$GlobalEventCopyWithImpl<$Res, _$GlobalEventImpl>
    implements _$$GlobalEventImplCopyWith<$Res> {
  __$$GlobalEventImplCopyWithImpl(
    _$GlobalEventImpl _value,
    $Res Function(_$GlobalEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GlobalEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? thumbnailUrl = null,
    Object? eventDate = null,
  }) {
    return _then(
      _$GlobalEventImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        thumbnailUrl: null == thumbnailUrl
            ? _value.thumbnailUrl
            : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        eventDate: null == eventDate
            ? _value.eventDate
            : eventDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$GlobalEventImpl implements _GlobalEvent {
  const _$GlobalEventImpl({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.eventDate,
  });

  @override
  final int id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String imageUrl;
  @override
  final String thumbnailUrl;
  @override
  final DateTime eventDate;

  @override
  String toString() {
    return 'GlobalEvent(id: $id, title: $title, description: $description, imageUrl: $imageUrl, thumbnailUrl: $thumbnailUrl, eventDate: $eventDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GlobalEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.eventDate, eventDate) ||
                other.eventDate == eventDate));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    imageUrl,
    thumbnailUrl,
    eventDate,
  );

  /// Create a copy of GlobalEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GlobalEventImplCopyWith<_$GlobalEventImpl> get copyWith =>
      __$$GlobalEventImplCopyWithImpl<_$GlobalEventImpl>(this, _$identity);
}

abstract class _GlobalEvent implements GlobalEvent {
  const factory _GlobalEvent({
    required final int id,
    required final String title,
    required final String description,
    required final String imageUrl,
    required final String thumbnailUrl,
    required final DateTime eventDate,
  }) = _$GlobalEventImpl;

  @override
  int get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get imageUrl;
  @override
  String get thumbnailUrl;
  @override
  DateTime get eventDate;

  /// Create a copy of GlobalEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GlobalEventImplCopyWith<_$GlobalEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
