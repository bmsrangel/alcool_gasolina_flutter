import 'package:alcool_gasolina/app/shared/services/local_storage_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SharedModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addSingleton(LocalStorageService.new);
  }
}
