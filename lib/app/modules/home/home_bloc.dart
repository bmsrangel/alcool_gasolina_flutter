import 'package:alcool_gasolina/app/modules/home/home_module.dart';
import 'package:alcool_gasolina/app/shared/services/local_storage_service.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {
  final LocalStorageService localStorageService;

  MaskedTextController gasolina$ = MaskedTextController(mask: "R\$0,00");
  MaskedTextController etanol$ = MaskedTextController(mask: "R\$0,00");

  MaskedTextController consumoGasolina$ = MaskedTextController(mask: "0,0");
  MaskedTextController consumoEtanol$ = MaskedTextController(mask: "0,0");

  FocusNode focusGasolina$ = FocusNode();
  FocusNode focusEtanol$ = FocusNode();
  FocusNode focusconsumoGasolina$ = FocusNode();
  FocusNode focusConsumoEtanol$ = FocusNode();

  BehaviorSubject<String> resultado$ = BehaviorSubject<String>();
  Sink<String> get inResultado => resultado$.sink;
  Stream<String> get outResultado => resultado$.stream;

  BehaviorSubject<bool> mostrarConsumo$ = BehaviorSubject<bool>.seeded(false);
  Sink<bool> get inMostrarConsumo => mostrarConsumo$.sink;
  Stream<bool> get outMostrarConsumo => mostrarConsumo$.stream;

  HomeBloc({this.localStorageService}) {
    _init();
  }

  _init() async {
    String consumoEtanol = await localStorageService.getConsumoEtanol();
    print(consumoEtanol);
    String consumoGasolina = await localStorageService.getConsumoGasolina();

    if (consumoEtanol != null) {
      consumoEtanol$.text = consumoEtanol;
    }
    if (consumoGasolina != null) {
      consumoGasolina$.text = consumoGasolina;
    }
  }

  void calcularResultado() async {
    focusConsumoEtanol$.unfocus();
    focusconsumoGasolina$.unfocus();
    focusEtanol$.unfocus();
    focusGasolina$.unfocus();

    double referencia = 0.70;
    double divisao;
    double consumoGasolina;
    double consumoEtanol;
    double precoGasolina =
        double.parse(gasolina$.text.replaceAll(",", ".").replaceAll("R\$", ""));
    double precoEtanol =
        double.parse(etanol$.text.replaceAll(",", ".").replaceAll("R\$", ""));

    if (mostrarConsumo$.value) {
      consumoGasolina =
          double.parse(consumoGasolina$.text.replaceAll(",", "."));
      consumoEtanol = double.parse(consumoEtanol$.text.replaceAll(",", "."));
      try {
        referencia = consumoEtanol / consumoGasolina;
        await localStorageService.setConsumoEtanol(consumoEtanol$.text);
        await localStorageService.setConsumoGasolina(consumoGasolina$.text);
      } catch (e) {
        print(e);
      }
    }

    try {
      divisao = precoEtanol / precoGasolina;
      if (divisao < referencia) {
        resultado$.sink.add("Etanol");
      } else {
        resultado$.sink.add("Gasolina");
      }
    } catch (e) {
      resultado$.sink.add(e);
    }
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    resultado$.close();
    mostrarConsumo$.close();
    super.dispose();
  }
}
