// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
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
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i278.ApiRepo>(() => registerModule.apirepo);
    gh.lazySingleton<_i932.ApiModelHazardRepo>(() => _i278.ApiRepo());
    gh.factory<_i259.ParkdataBloc>(
        () => _i259.ParkdataBloc(gh<_i932.ApiModelHazardRepo>()));
    return this;
  }
}

class _$RegisterModule extends _i1014.RegisterModule {
  @override
  _i278.ApiRepo get apirepo => _i278.ApiRepo();
}
