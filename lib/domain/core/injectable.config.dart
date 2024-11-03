// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
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
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.ApiRepo>(() => registerModule.apirepo);
    gh.lazySingleton<_i4.ApiModelHazardRepo>(() => _i3.ApiRepo());
    gh.factory<_i5.ParkdataBloc>(
        () => _i5.ParkdataBloc(gh<_i4.ApiModelHazardRepo>()));
    return this;
  }
}

class _$RegisterModule extends _i6.RegisterModule {
  @override
  _i3.ApiRepo get apirepo => _i3.ApiRepo();
}
