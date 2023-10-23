import 'package:alcool_gasolina/app/shared/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends Bloc implements Disposable {
  HomeBloc({required this.localStorageService}) : super(null) {
    _init();
  }

  final LocalStorageService localStorageService;

  MoneyMaskedTextController gasolina$ = MoneyMaskedTextController(
    leftSymbol: "R\$",
    precision: 2,
    decimalSeparator: ",",
    thousandSeparator: ".",
  );
  MoneyMaskedTextController etanol$ = MoneyMaskedTextController(
    leftSymbol: "R\$",
    precision: 2,
    decimalSeparator: ",",
    thousandSeparator: ".",
  );

  MoneyMaskedTextController consumoGasolina$ = MoneyMaskedTextController(
    rightSymbol: " km/l",
    precision: 1,
  );
  MoneyMaskedTextController consumoEtanol$ = MoneyMaskedTextController(
    rightSymbol: " km/l",
    precision: 1,
  );

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

  _init() async {
    String? consumoEtanol = await localStorageService.getConsumoEtanol();
    String? consumoGasolina = await localStorageService.getConsumoGasolina();

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
      consumoGasolina = double.parse(
          consumoGasolina$.text.replaceAll(",", ".").replaceAll(" km/l", ""));
      consumoEtanol = double.parse(
          consumoEtanol$.text.replaceAll(",", ".").replaceAll(" km/l", ""));
      if (consumoGasolina != 0.0 && consumoEtanol != 0.0) {
        try {
          referencia = consumoEtanol / consumoGasolina;
          await localStorageService.setConsumoEtanol(consumoEtanol$.text);
          await localStorageService.setConsumoGasolina(consumoGasolina$.text);
        } catch (e) {
          print(e);
        }
      }
    }

    if (precoEtanol != 0.0 && precoGasolina != 0.0) {
      try {
        divisao = precoEtanol / precoGasolina;
        if (divisao < referencia) {
          resultado$.sink.add("Etanol");
        } else {
          resultado$.sink.add("Gasolina");
        }
      } catch (e) {
        resultado$.addError(e);
      }
    }
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    resultado$.close();
    mostrarConsumo$.close();
  }
}
