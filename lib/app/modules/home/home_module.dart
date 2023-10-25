import 'package:alcool_gasolina/app/modules/home/blocs/consumption_result/consumption_result_cubit.dart';
import 'package:alcool_gasolina/app/modules/home/components/fuel_consumption/fuel_consumption_controller.dart';
import 'package:alcool_gasolina/app/modules/home/home_bloc.dart';
import 'package:alcool_gasolina/app/modules/home/home_page.dart';
import 'package:alcool_gasolina/app/shared/shared_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [
        SharedModule(),
      ];

  @override
  void binds(Injector i) {
    i.addSingleton(HomeBloc.new);
    i.add(ConsumptionResultCubit.new);
    i.add(FuelConsumptionController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (_) => HomePage(),
    );
  }
}
