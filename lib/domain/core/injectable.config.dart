// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
<<<<<<< HEAD
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:ParkAvail/application/bloc/parkdata_bloc.dart' as _i259;
import 'package:ParkAvail/domain/core/injectable.dart' as _i1014;
import 'package:ParkAvail/domain/models/apimodelrepo.dart' as _i932;
import 'package:ParkAvail/infrastructure/apirepo.dart' as _i278;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
=======
import 'package:book_my_park/application/bloc/parkdata_bloc.dart' as _i5;
import 'package:book_my_park/domain/core/injectable.dart' as _i6;
import 'package:book_my_park/domain/models/apimodelrepo.dart' as _i4;
import 'package:book_my_park/infrastructure/apirepo.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
<<<<<<< HEAD
    gh.lazySingleton<_i278.ApiRepo>(() => registerModule.apirepo);
    gh.lazySingleton<_i932.ApiModelHazardRepo>(() => _i278.ApiRepo());
    gh.factory<_i259.ParkdataBloc>(
        () => _i259.ParkdataBloc(gh<_i932.ApiModelHazardRepo>()));
=======
    gh.lazySingleton<_i3.ApiRepo>(() => registerModule.apirepo);
    gh.lazySingleton<_i4.ApiModelHazardRepo>(() => _i3.ApiRepo());
    gh.factory<_i5.ParkdataBloc>(
        () => _i5.ParkdataBloc(gh<_i4.ApiModelHazardRepo>()));
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
    return this;
  }
}

<<<<<<< HEAD
class _$RegisterModule extends _i1014.RegisterModule {
  @override
  _i278.ApiRepo get apirepo => _i278.ApiRepo();
=======
class _$RegisterModule extends _i6.RegisterModule {
  @override
  _i3.ApiRepo get apirepo => _i3.ApiRepo();
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
}
