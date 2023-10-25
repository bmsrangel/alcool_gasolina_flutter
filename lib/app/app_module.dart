import 'package:alcool_gasolina/app/modules/home/home_module.dart';
import 'package:alcool_gasolina/app/modules/splash/splash_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.module(Modular.initialRoute, module: HomeModule());
    r.module('/splash', module: SplashModule());
  }
}
