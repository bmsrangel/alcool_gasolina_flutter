import 'package:alcool_gasolina/app/shared/services/local_storage_service.dart';

class FuelConsumptionController {
  FuelConsumptionController(this._service);

  final LocalStorageService _service;

  Future<void> setGasCityConsumption(String value) async {
    await _service.setGasolineCityConsumption(value);
  }

  Future<void> setGasRoadConsumption(String value) async {
    await _service.setGasolineRoadConsumption(value);
  }

  Future<void> setEthanolCityConsumption(String value) async {
    await _service.setEthanolCityConsumption(value);
  }

  Future<void> setEthanolRoadConsumption(String value) async {
    await _service.setEthanolRoadConsumption(value);
  }

  Future<String> getGasCityConsumption() async {
    final value = await _service.getGasolineCityConsumption();
    return value ?? '';
  }

  Future<String> getGasRoadConsumption() async {
    final value = await _service.getGasolineRoadConsumption();
    return value ?? '';
  }

  Future<String> getEthanolCityConsumption() async {
    final value = await _service.getEthanolCityConsumption();
    return value ?? '';
  }

  Future<String> getEthanolRoadConsumption() async {
    final value = await _service.getEthanolRoadConsumption();
    return value ?? '';
  }
}
