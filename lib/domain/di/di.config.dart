// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../application/datafetch/data_bloc.dart' as _i7;
import '../../application/details/details_bloc.dart' as _i3;
import '../../application/Home/home_bloc.dart' as _i4;
import '../../infastructure/datafetch/datafetch.dart' as _i6;
import '../datafetch/idatafetch.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.DetailsBloc>(() => _i3.DetailsBloc());
  gh.factory<_i4.HomeBloc>(() => _i4.HomeBloc());
  gh.lazySingleton<_i5.IDataFetch>(() => _i6.FetchRepositry());
  gh.factory<_i7.DataBloc>(() => _i7.DataBloc(get<_i5.IDataFetch>()));
  return get;
}
