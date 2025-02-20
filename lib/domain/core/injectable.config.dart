// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:parkavail/application/bloc/parkdata_bloc.dart' as _i677;
import 'package:parkavail/domain/core/injectable.dart' as _i77;
import 'package:parkavail/domain/models/apimodelrepo.dart' as _i360;
import 'package:parkavail/infrastructure/apirepo.dart' as _i453;

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
    gh.lazySingleton<_i453.ApiRepo>(() => registerModule.apirepo);
    gh.lazySingleton<_i360.ApiModelHazardRepo>(() => _i453.ApiRepo());
    gh.factory<_i677.ParkdataBloc>(
        () => _i677.ParkdataBloc(gh<_i360.ApiModelHazardRepo>()));
    return this;
  }
}

class _$RegisterModule extends _i77.RegisterModule {
  @override
  _i453.ApiRepo get apirepo => _i453.ApiRepo();
}
