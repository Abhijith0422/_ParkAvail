import 'package:ParkAvail/domain/core/injectable.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../infrastructure/apirepo.dart';

final getit = GetIt.instance;
@InjectableInit(initializerName: 'init')
Future<void> configureInjection() async {
  getit.init(environment: Environment.prod);
}

@module
abstract class RegisterModule {
  @lazySingleton
  ApiRepo get apirepo;
}
