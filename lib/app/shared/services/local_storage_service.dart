import 'dart:async';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class LocalStorageService {
  Completer<Box> completer = Completer<Box>();

  LocalStorageService() {}

  Future<void> init() async {
    final directory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    final box = await Hive.openBox("consumptions");
    if (!completer.isCompleted) completer.complete(box);
  }

  Future<void> setEthanolCityConsumption(String ethanolConsumption) async {
    final box = await completer.future;
    await box.put("ethanolCityConsumption", ethanolConsumption);
  }

  Future<void> setGasolineCityConsumption(String gasolineConsumption) async {
    final box = await completer.future;
    await box.put("gasolineCityConsumption", gasolineConsumption);
  }

  Future<String?> getEthanolCityConsumption() async {
    final box = await completer.future;
    try {
      return box.get("ethanolCityConsumption");
      // return localStorage.getString("consumoEtanol");
    } catch (e) {
      return null;
    }
  }

  Future<String?> getGasolineCityConsumption() async {
    final box = await completer.future;
    try {
      return box.get("gasolineCityConsumption");
    } catch (e) {
      return null;
    }
  }

  Future<void> setEthanolRoadConsumption(String ethanolConsumption) async {
    final box = await completer.future;
    await box.put("ethanolRoadConsumption", ethanolConsumption);
  }

  Future<void> setGasolineRoadConsumption(String gasolineConsumption) async {
    final box = await completer.future;
    await box.put("gasolineRoadConsumption", gasolineConsumption);
  }

  Future<String?> getEthanolRoadConsumption() async {
    final box = await completer.future;
    try {
      return box.get("ethanolRoadConsumption");
      // return localStorage.getString("consumoEtanol");
    } catch (e) {
      return null;
    }
  }

  Future<String?> getGasolineRoadConsumption() async {
    final box = await completer.future;
    try {
      return box.get("gasolineRoadConsumption");
    } catch (e) {
      return null;
    }
  }
}
