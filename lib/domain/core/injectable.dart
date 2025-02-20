<<<<<<< HEAD
import 'package:ParkAvail/domain/core/injectable.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../infrastructure/apirepo.dart';

final getit = GetIt.instance;
@InjectableInit(initializerName: 'init')
=======
import 'package:book_my_park/domain/core/injectable.config.dart';
import 'package:book_my_park/infrastructure/apirepo.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getit = GetIt.instance;
@InjectableInit(
  initializerName: 'init',
)
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
Future<void> configureInjection() async {
  getit.init(environment: Environment.prod);
}

@module
abstract class RegisterModule {
  @lazySingleton
  ApiRepo get apirepo;
}
