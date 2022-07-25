// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MainFailure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() clientFailure,
    required TResult Function(FirebaseException err) firebaseException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? clientFailure,
    TResult Function(FirebaseException err)? firebaseException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? clientFailure,
    TResult Function(FirebaseException err)? firebaseException,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ClientFailure value) clientFailure,
    required TResult Function(FirebaseException value) firebaseException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ClientFailure value)? clientFailure,
    TResult Function(FirebaseException value)? firebaseException,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ClientFailure value)? clientFailure,
    TResult Function(FirebaseException value)? firebaseException,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainFailureCopyWith<$Res> {
  factory $MainFailureCopyWith(
          MainFailure value, $Res Function(MainFailure) then) =
      _$MainFailureCopyWithImpl<$Res>;
}

/// @nodoc
class _$MainFailureCopyWithImpl<$Res> implements $MainFailureCopyWith<$Res> {
  _$MainFailureCopyWithImpl(this._value, this._then);

  final MainFailure _value;
  // ignore: unused_field
  final $Res Function(MainFailure) _then;
}

/// @nodoc
abstract class _$$_ClientFailureCopyWith<$Res> {
  factory _$$_ClientFailureCopyWith(
          _$_ClientFailure value, $Res Function(_$_ClientFailure) then) =
      __$$_ClientFailureCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_ClientFailureCopyWithImpl<$Res>
    extends _$MainFailureCopyWithImpl<$Res>
    implements _$$_ClientFailureCopyWith<$Res> {
  __$$_ClientFailureCopyWithImpl(
      _$_ClientFailure _value, $Res Function(_$_ClientFailure) _then)
      : super(_value, (v) => _then(v as _$_ClientFailure));

  @override
  _$_ClientFailure get _value => super._value as _$_ClientFailure;
}

/// @nodoc

class _$_ClientFailure implements _ClientFailure {
  const _$_ClientFailure();

  @override
  String toString() {
    return 'MainFailure.clientFailure()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_ClientFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() clientFailure,
    required TResult Function(FirebaseException err) firebaseException,
  }) {
    return clientFailure();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? clientFailure,
    TResult Function(FirebaseException err)? firebaseException,
  }) {
    return clientFailure?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? clientFailure,
    TResult Function(FirebaseException err)? firebaseException,
    required TResult orElse(),
  }) {
    if (clientFailure != null) {
      return clientFailure();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ClientFailure value) clientFailure,
    required TResult Function(FirebaseException value) firebaseException,
  }) {
    return clientFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ClientFailure value)? clientFailure,
    TResult Function(FirebaseException value)? firebaseException,
  }) {
    return clientFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ClientFailure value)? clientFailure,
    TResult Function(FirebaseException value)? firebaseException,
    required TResult orElse(),
  }) {
    if (clientFailure != null) {
      return clientFailure(this);
    }
    return orElse();
  }
}

abstract class _ClientFailure implements MainFailure {
  const factory _ClientFailure() = _$_ClientFailure;
}

/// @nodoc
abstract class _$$FirebaseExceptionCopyWith<$Res> {
  factory _$$FirebaseExceptionCopyWith(
          _$FirebaseException value, $Res Function(_$FirebaseException) then) =
      __$$FirebaseExceptionCopyWithImpl<$Res>;
  $Res call({FirebaseException err});
}

/// @nodoc
class __$$FirebaseExceptionCopyWithImpl<$Res>
    extends _$MainFailureCopyWithImpl<$Res>
    implements _$$FirebaseExceptionCopyWith<$Res> {
  __$$FirebaseExceptionCopyWithImpl(
      _$FirebaseException _value, $Res Function(_$FirebaseException) _then)
      : super(_value, (v) => _then(v as _$FirebaseException));

  @override
  _$FirebaseException get _value => super._value as _$FirebaseException;

  @override
  $Res call({
    Object? err = freezed,
  }) {
    return _then(_$FirebaseException(
      err: err == freezed
          ? _value.err
          : err // ignore: cast_nullable_to_non_nullable
              as FirebaseException,
    ));
  }
}

/// @nodoc

class _$FirebaseException implements FirebaseException {
  _$FirebaseException({required this.err});

  @override
  final FirebaseException err;

  @override
  String toString() {
    return 'MainFailure.firebaseException(err: $err)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FirebaseException &&
            const DeepCollectionEquality().equals(other.err, err));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(err));

  @JsonKey(ignore: true)
  @override
  _$$FirebaseExceptionCopyWith<_$FirebaseException> get copyWith =>
      __$$FirebaseExceptionCopyWithImpl<_$FirebaseException>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() clientFailure,
    required TResult Function(FirebaseException err) firebaseException,
  }) {
    return firebaseException(err);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? clientFailure,
    TResult Function(FirebaseException err)? firebaseException,
  }) {
    return firebaseException?.call(err);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? clientFailure,
    TResult Function(FirebaseException err)? firebaseException,
    required TResult orElse(),
  }) {
    if (firebaseException != null) {
      return firebaseException(err);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ClientFailure value) clientFailure,
    required TResult Function(FirebaseException value) firebaseException,
  }) {
    return firebaseException(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ClientFailure value)? clientFailure,
    TResult Function(FirebaseException value)? firebaseException,
  }) {
    return firebaseException?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ClientFailure value)? clientFailure,
    TResult Function(FirebaseException value)? firebaseException,
    required TResult orElse(),
  }) {
    if (firebaseException != null) {
      return firebaseException(this);
    }
    return orElse();
  }
}

abstract class FirebaseException implements MainFailure {
  factory FirebaseException({required final FirebaseException err}) =
      _$FirebaseException;

  FirebaseException get err => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$FirebaseExceptionCopyWith<_$FirebaseException> get copyWith =>
      throw _privateConstructorUsedError;
}
