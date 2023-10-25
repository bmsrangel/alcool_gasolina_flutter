import 'package:alcool_gasolina/app/modules/splash/splash_page.dart';
import 'package:alcool_gasolina/app/shared/shared_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends Module {
  @override
  List<Module> get imports => [
        SharedModule(),
      ];

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (_) => SplashPage());
  }
}
