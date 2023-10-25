import 'package:alcool_gasolina/app/modules/home/components/fuel_consumption/fuel_consumption_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FuelConsumptionWidget extends StatefulWidget {
  const FuelConsumptionWidget({
    super.key,
    required this.consumptionGasCity,
    required this.consumptionGasRoad,
    required this.consumptionEthanolCity,
    required this.consumptionEthanolRoad,
    this.onSwitch,
  });

  final MoneyMaskedTextController consumptionGasCity;
  final MoneyMaskedTextController consumptionGasRoad;
  final MoneyMaskedTextController consumptionEthanolCity;
  final MoneyMaskedTextController consumptionEthanolRoad;
  final void Function(bool value)? onSwitch;

  @override
  State<FuelConsumptionWidget> createState() => _FuelConsumptionWidgetState();
}

class _FuelConsumptionWidgetState extends State<FuelConsumptionWidget> {
  bool _showConsumption = false;

  late final FuelConsumptionController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<FuelConsumptionController>();
    _controller.getEthanolCityConsumption().then((value) {
      if (value.isNotEmpty) {
        widget.consumptionEthanolCity.text = value;
      }
      widget.consumptionEthanolCity.addListener(
        _ethanolCityConsumptionListener,
      );
    });
    _controller.getEthanolRoadConsumption().then((value) {
      if (value.isNotEmpty) {
        widget.consumptionEthanolRoad.text = value;
      }
      widget.consumptionEthanolRoad.addListener(
        _ethanolRoadConsumptionListener,
      );
    });
    _controller.getGasCityConsumption().then((value) {
      if (value.isNotEmpty) {
        widget.consumptionGasCity.text = value;
      }
      widget.consumptionGasCity.addListener(_gasCityConsumptionListener);
    });
    _controller.getGasRoadConsumption().then((value) {
      if (value.isNotEmpty) {
        widget.consumptionGasRoad.text = value;
      }
      widget.consumptionGasRoad.addListener(_gasRoadConsumptionListener);
    });
  }

  @override
  void dispose() {
    widget.consumptionEthanolCity.removeListener(
      _ethanolCityConsumptionListener,
    );
    widget.consumptionEthanolRoad.removeListener(
      _ethanolRoadConsumptionListener,
    );
    widget.consumptionGasCity.removeListener(
      _gasCityConsumptionListener,
    );
    widget.consumptionGasRoad.removeListener(
      _gasRoadConsumptionListener,
    );
    super.dispose();
  }

  void _gasCityConsumptionListener() {
    _controller.setGasCityConsumption(widget.consumptionGasCity.text);
  }

  void _gasRoadConsumptionListener() {
    _controller.setGasRoadConsumption(widget.consumptionGasRoad.text);
  }

  void _ethanolCityConsumptionListener() {
    _controller.setEthanolCityConsumption(widget.consumptionEthanolCity.text);
  }

  void _ethanolRoadConsumptionListener() {
    _controller.setEthanolRoadConsumption(widget.consumptionEthanolRoad.text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text("Incluir consumo do veículo"),
            Switch(
              value: _showConsumption,
              onChanged: (bool value) {
                setState(() {
                  _showConsumption = !_showConsumption;
                });
                widget.onSwitch?.call(value);
              },
            ),
          ],
        ),
        _showConsumption ? consumption() : SizedBox.shrink(),
      ],
    );
  }

  Widget consumption() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Consumos',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            entradasConsumo(
              "Gasolina",
              widget.consumptionGasCity,
              widget.consumptionGasRoad,
              Colors.red,
            ),
            entradasConsumo(
              "Etanol",
              widget.consumptionEthanolCity,
              widget.consumptionEthanolRoad,
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget entradasConsumo(
    String combustivel,
    MoneyMaskedTextController cityController,
    MoneyMaskedTextController roadController,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: cityController,
              cursorColor: color,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "$combustivel - Cidade",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: color),
                ),
                floatingLabelStyle:
                    MaterialStateTextStyle.resolveWith((states) {
                  if (states.contains(MaterialState.focused)) {
                    return TextStyle(color: color);
                  } else {
                    return TextStyle();
                  }
                }),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Campo obrigatório';
                } else if (cityController.numberValue <= 0) {
                  return 'Valor inválido';
                } else {
                  return null;
                }
              },
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: roadController,
              cursorColor: color,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "$combustivel - Estrada",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: color),
                ),
                floatingLabelStyle:
                    MaterialStateTextStyle.resolveWith((states) {
                  if (states.contains(MaterialState.focused)) {
                    return TextStyle(color: color);
                  } else {
                    return TextStyle();
                  }
                }),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Campo obrigatório';
                } else if (cityController.numberValue <= 0) {
                  return 'Valor inválido';
                } else {
                  return null;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
