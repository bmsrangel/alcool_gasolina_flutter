import 'package:alcool_gasolina/app/modules/home/home_bloc.dart';
import 'package:alcool_gasolina/app/modules/home/home_page.dart';
import 'package:alcool_gasolina/app/shared/services/local_storage_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton(LocalStorageService.new);
    i.addSingleton(HomeBloc.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => HomePage(),
    );
  }
}
