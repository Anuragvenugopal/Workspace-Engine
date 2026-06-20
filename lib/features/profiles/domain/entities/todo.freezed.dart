// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Todo {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  bool get isImportant => throw _privateConstructorUsedError;
  DateTime? get dueDate => throw _privateConstructorUsedError;
  String get profileId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of Todo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodoCopyWith<Todo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoCopyWith<$Res> {
  factory $TodoCopyWith(Todo value, $Res Function(Todo) then) =
      _$TodoCopyWithImpl<$Res, Todo>;
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    bool isCompleted,
    bool isImportant,
    DateTime? dueDate,
    String profileId,
    DateTime createdAt,
  });
}

/// @nodoc
class _$TodoCopyWithImpl<$Res, $Val extends Todo>
    implements $TodoCopyWith<$Res> {
  _$TodoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Todo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? isCompleted = null,
    Object? isImportant = null,
    Object? dueDate = freezed,
    Object? profileId = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            isCompleted: null == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            isImportant: null == isImportant
                ? _value.isImportant
                : isImportant // ignore: cast_nullable_to_non_nullable
                      as bool,
            dueDate: freezed == dueDate
                ? _value.dueDate
                : dueDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            profileId: null == profileId
                ? _value.profileId
                : profileId // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TodoImplCopyWith<$Res> implements $TodoCopyWith<$Res> {
  factory _$$TodoImplCopyWith(
    _$TodoImpl value,
    $Res Function(_$TodoImpl) then,
  ) = __$$TodoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    bool isCompleted,
    bool isImportant,
    DateTime? dueDate,
    String profileId,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$TodoImplCopyWithImpl<$Res>
    extends _$TodoCopyWithImpl<$Res, _$TodoImpl>
    implements _$$TodoImplCopyWith<$Res> {
  __$$TodoImplCopyWithImpl(_$TodoImpl _value, $Res Function(_$TodoImpl) _then)
    : super(_value, _then);

  /// Create a copy of Todo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? isCompleted = null,
    Object? isImportant = null,
    Object? dueDate = freezed,
    Object? profileId = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$TodoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        isCompleted: null == isCompleted
            ? _value.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        isImportant: null == isImportant
            ? _value.isImportant
            : isImportant // ignore: cast_nullable_to_non_nullable
                  as bool,
        dueDate: freezed == dueDate
            ? _value.dueDate
            : dueDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        profileId: null == profileId
            ? _value.profileId
            : profileId // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$TodoImpl implements _Todo {
  const _$TodoImpl({
    required this.id,
    required this.title,
    this.description,
    required this.isCompleted,
    required this.isImportant,
    this.dueDate,
    required this.profileId,
    required this.createdAt,
  });

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final bool isCompleted;
  @override
  final bool isImportant;
  @override
  final DateTime? dueDate;
  @override
  final String profileId;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, description: $description, isCompleted: $isCompleted, isImportant: $isImportant, dueDate: $dueDate, profileId: $profileId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.isImportant, isImportant) ||
                other.isImportant == isImportant) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    isCompleted,
    isImportant,
    dueDate,
    profileId,
    createdAt,
  );

  /// Create a copy of Todo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoImplCopyWith<_$TodoImpl> get copyWith =>
      __$$TodoImplCopyWithImpl<_$TodoImpl>(this, _$identity);
}

abstract class _Todo implements Todo {
  const factory _Todo({
    required final String id,
    required final String title,
    final String? description,
    required final bool isCompleted,
    required final bool isImportant,
    final DateTime? dueDate,
    required final String profileId,
    required final DateTime createdAt,
  }) = _$TodoImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  bool get isCompleted;
  @override
  bool get isImportant;
  @override
  DateTime? get dueDate;
  @override
  String get profileId;
  @override
  DateTime get createdAt;

  /// Create a copy of Todo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoImplCopyWith<_$TodoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
