// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'data_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DataEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function() getdata,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function()? getdata,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function()? getdata,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialized value) initialized,
    required TResult Function(Getdata value) getdata,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initialized value)? initialized,
    TResult Function(Getdata value)? getdata,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialized value)? initialized,
    TResult Function(Getdata value)? getdata,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataEventCopyWith<$Res> {
  factory $DataEventCopyWith(DataEvent value, $Res Function(DataEvent) then) =
      _$DataEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$DataEventCopyWithImpl<$Res> implements $DataEventCopyWith<$Res> {
  _$DataEventCopyWithImpl(this._value, this._then);

  final DataEvent _value;
  // ignore: unused_field
  final $Res Function(DataEvent) _then;
}

/// @nodoc
abstract class _$$InitializedCopyWith<$Res> {
  factory _$$InitializedCopyWith(
          _$Initialized value, $Res Function(_$Initialized) then) =
      __$$InitializedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitializedCopyWithImpl<$Res> extends _$DataEventCopyWithImpl<$Res>
    implements _$$InitializedCopyWith<$Res> {
  __$$InitializedCopyWithImpl(
      _$Initialized _value, $Res Function(_$Initialized) _then)
      : super(_value, (v) => _then(v as _$Initialized));

  @override
  _$Initialized get _value => super._value as _$Initialized;
}

/// @nodoc

class _$Initialized implements Initialized {
  const _$Initialized();

  @override
  String toString() {
    return 'DataEvent.initialized()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Initialized);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function() getdata,
  }) {
    return initialized();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function()? getdata,
  }) {
    return initialized?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function()? getdata,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialized value) initialized,
    required TResult Function(Getdata value) getdata,
  }) {
    return initialized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initialized value)? initialized,
    TResult Function(Getdata value)? getdata,
  }) {
    return initialized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialized value)? initialized,
    TResult Function(Getdata value)? getdata,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(this);
    }
    return orElse();
  }
}

abstract class Initialized implements DataEvent {
  const factory Initialized() = _$Initialized;
}

/// @nodoc
abstract class _$$GetdataCopyWith<$Res> {
  factory _$$GetdataCopyWith(_$Getdata value, $Res Function(_$Getdata) then) =
      __$$GetdataCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetdataCopyWithImpl<$Res> extends _$DataEventCopyWithImpl<$Res>
    implements _$$GetdataCopyWith<$Res> {
  __$$GetdataCopyWithImpl(_$Getdata _value, $Res Function(_$Getdata) _then)
      : super(_value, (v) => _then(v as _$Getdata));

  @override
  _$Getdata get _value => super._value as _$Getdata;
}

/// @nodoc

class _$Getdata implements Getdata {
  const _$Getdata();

  @override
  String toString() {
    return 'DataEvent.getdata()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Getdata);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialized,
    required TResult Function() getdata,
  }) {
    return getdata();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function()? getdata,
  }) {
    return getdata?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialized,
    TResult Function()? getdata,
    required TResult orElse(),
  }) {
    if (getdata != null) {
      return getdata();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initialized value) initialized,
    required TResult Function(Getdata value) getdata,
  }) {
    return getdata(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Initialized value)? initialized,
    TResult Function(Getdata value)? getdata,
  }) {
    return getdata?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initialized value)? initialized,
    TResult Function(Getdata value)? getdata,
    required TResult orElse(),
  }) {
    if (getdata != null) {
      return getdata(this);
    }
    return orElse();
  }
}

abstract class Getdata implements DataEvent {
  const factory Getdata() = _$Getdata;
}

/// @nodoc
mixin _$DataState {
  bool get isLoading => throw _privateConstructorUsedError;
  PUserModel? get userModel => throw _privateConstructorUsedError;
  Option<Either<MainFailure, PUserModel>> get datafetchstate =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DataStateCopyWith<DataState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataStateCopyWith<$Res> {
  factory $DataStateCopyWith(DataState value, $Res Function(DataState) then) =
      _$DataStateCopyWithImpl<$Res>;
  $Res call(
      {bool isLoading,
      PUserModel? userModel,
      Option<Either<MainFailure, PUserModel>> datafetchstate});
}

/// @nodoc
class _$DataStateCopyWithImpl<$Res> implements $DataStateCopyWith<$Res> {
  _$DataStateCopyWithImpl(this._value, this._then);

  final DataState _value;
  // ignore: unused_field
  final $Res Function(DataState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? userModel = freezed,
    Object? datafetchstate = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      userModel: userModel == freezed
          ? _value.userModel
          : userModel // ignore: cast_nullable_to_non_nullable
              as PUserModel?,
      datafetchstate: datafetchstate == freezed
          ? _value.datafetchstate
          : datafetchstate // ignore: cast_nullable_to_non_nullable
              as Option<Either<MainFailure, PUserModel>>,
    ));
  }
}

/// @nodoc
abstract class _$$_DataStateCopyWith<$Res> implements $DataStateCopyWith<$Res> {
  factory _$$_DataStateCopyWith(
          _$_DataState value, $Res Function(_$_DataState) then) =
      __$$_DataStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isLoading,
      PUserModel? userModel,
      Option<Either<MainFailure, PUserModel>> datafetchstate});
}

/// @nodoc
class __$$_DataStateCopyWithImpl<$Res> extends _$DataStateCopyWithImpl<$Res>
    implements _$$_DataStateCopyWith<$Res> {
  __$$_DataStateCopyWithImpl(
      _$_DataState _value, $Res Function(_$_DataState) _then)
      : super(_value, (v) => _then(v as _$_DataState));

  @override
  _$_DataState get _value => super._value as _$_DataState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? userModel = freezed,
    Object? datafetchstate = freezed,
  }) {
    return _then(_$_DataState(
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      userModel: userModel == freezed
          ? _value.userModel
          : userModel // ignore: cast_nullable_to_non_nullable
              as PUserModel?,
      datafetchstate: datafetchstate == freezed
          ? _value.datafetchstate
          : datafetchstate // ignore: cast_nullable_to_non_nullable
              as Option<Either<MainFailure, PUserModel>>,
    ));
  }
}

/// @nodoc

class _$_DataState implements _DataState {
  const _$_DataState(
      {required this.isLoading, this.userModel, required this.datafetchstate});

  @override
  final bool isLoading;
  @override
  final PUserModel? userModel;
  @override
  final Option<Either<MainFailure, PUserModel>> datafetchstate;

  @override
  String toString() {
    return 'DataState(isLoading: $isLoading, userModel: $userModel, datafetchstate: $datafetchstate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DataState &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading) &&
            const DeepCollectionEquality().equals(other.userModel, userModel) &&
            const DeepCollectionEquality()
                .equals(other.datafetchstate, datafetchstate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isLoading),
      const DeepCollectionEquality().hash(userModel),
      const DeepCollectionEquality().hash(datafetchstate));

  @JsonKey(ignore: true)
  @override
  _$$_DataStateCopyWith<_$_DataState> get copyWith =>
      __$$_DataStateCopyWithImpl<_$_DataState>(this, _$identity);
}

abstract class _DataState implements DataState {
  const factory _DataState(
      {required final bool isLoading,
      final PUserModel? userModel,
      required final Option<Either<MainFailure, PUserModel>>
          datafetchstate}) = _$_DataState;

  @override
  bool get isLoading;
  @override
  PUserModel? get userModel;
  @override
  Option<Either<MainFailure, PUserModel>> get datafetchstate;
  @override
  @JsonKey(ignore: true)
  _$$_DataStateCopyWith<_$_DataState> get copyWith =>
      throw _privateConstructorUsedError;
}
