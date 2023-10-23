import 'dart:async';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class LocalStorageService {
  Completer<Box> completer = Completer<Box>();

  LocalStorageService() {
    _init();
  }

  _init() async {
    final directory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    final box = await Hive.openBox("consumos");
    if (!completer.isCompleted) completer.complete(box);
  }

  Future<void> setConsumoEtanol(String consumoEtanol) async {
    final box = await completer.future;
    await box.put("consumoEtanol", consumoEtanol);
  }

  Future<void> setConsumoGasolina(String consumoGasolina) async {
    final box = await completer.future;
    await box.put("consumoGasolina", consumoGasolina);
  }

  Future<String?> getConsumoEtanol() async {
    final box = await completer.future;
    try {
      return box.get("consumoEtanol");
      // return localStorage.getString("consumoEtanol");
    } catch (e) {
      return null;
    }
  }

  Future<String?> getConsumoGasolina() async {
    final box = await completer.future;
    try {
      return box.get("consumoGasolina");
    } catch (e) {
      return null;
    }
  }
}
