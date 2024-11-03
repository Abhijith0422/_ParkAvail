import 'package:book_my_park/domain/core/injectable.config.dart';
import 'package:book_my_park/infrastructure/apirepo.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getit = GetIt.instance;
@InjectableInit(
  initializerName: 'init',
)
Future<void> configureInjection() async {
  getit.init(environment: Environment.prod);
}

@module
abstract class RegisterModule {
  @lazySingleton
  ApiRepo get apirepo;
}
