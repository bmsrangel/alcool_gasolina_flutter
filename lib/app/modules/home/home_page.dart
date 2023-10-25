import 'package:alcool_gasolina/app/modules/home/blocs/consumption_result/consumption_result_cubit.dart';
import 'package:alcool_gasolina/app/modules/home/components/fuel_consumption/fuel_consumption_widget.dart';
import 'package:alcool_gasolina/app/modules/home/components/fuel_price/fuel_price_widget.dart';
import 'package:alcool_gasolina/app/modules/home/enums/fuel_recommendation_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'components/header/header_widget.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ConsumptionResultCubit _generalResultCubit =
      Modular.get<ConsumptionResultCubit>();
  final ConsumptionResultCubit _cityResultCubit =
      Modular.get<ConsumptionResultCubit>();
  final ConsumptionResultCubit _roadResultCubit =
      Modular.get<ConsumptionResultCubit>();

  bool _showConsumption = false;

  final _gasPrice$ = MoneyMaskedTextController(
    leftSymbol: "R\$",
    precision: 2,
    decimalSeparator: ",",
    thousandSeparator: ".",
  );
  final _ethanolPrice$ = MoneyMaskedTextController(
    leftSymbol: "R\$",
    precision: 2,
    decimalSeparator: ",",
    thousandSeparator: ".",
  );

  final _consumptionGasCity$ = MoneyMaskedTextController(
    rightSymbol: " km/l",
    precision: 1,
  );
  final _consumptionEthanolCity$ = MoneyMaskedTextController(
    rightSymbol: " km/l",
    precision: 1,
  );
  final _consumptionGasRoad$ = MoneyMaskedTextController(
    rightSymbol: " km/l",
    precision: 1,
  );
  final _consumptionEthanolRoad$ = MoneyMaskedTextController(
    rightSymbol: " km/l",
    precision: 1,
  );

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _gasPrice$.dispose();
    _ethanolPrice$.dispose();
    _consumptionEthanolCity$.dispose();
    _consumptionEthanolRoad$.dispose();
    _consumptionGasCity$.dispose();
    _consumptionGasRoad$.dispose();
    _generalResultCubit.close();
    _cityResultCubit.close();
    _roadResultCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          HeaderWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Preços',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              FuelPriceWidget(
                                fuel: "Gasolina",
                                controller: _gasPrice$,
                                color: Colors.red,
                              ),
                              SizedBox(height: 15),
                              FuelPriceWidget(
                                fuel: "Etanol",
                                controller: _ethanolPrice$,
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      FuelConsumptionWidget(
                        consumptionEthanolCity: _consumptionEthanolCity$,
                        consumptionEthanolRoad: _consumptionEthanolRoad$,
                        consumptionGasCity: _consumptionGasCity$,
                        consumptionGasRoad: _consumptionGasRoad$,
                        onSwitch: (value) {
                          setState(() {
                            _showConsumption = value;
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            "Calcular",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (_formKey.currentState!.validate()) {
                            if (_showConsumption) {
                              _cityResultCubit.calculate(
                                gasPrice: _gasPrice$.numberValue,
                                ethanolPrice: _ethanolPrice$.numberValue,
                                ethanolConsumption:
                                    _consumptionEthanolCity$.numberValue,
                                gasConsumption:
                                    _consumptionGasCity$.numberValue,
                              );
                              _roadResultCubit.calculate(
                                gasPrice: _gasPrice$.numberValue,
                                ethanolPrice: _ethanolPrice$.numberValue,
                                ethanolConsumption:
                                    _consumptionEthanolRoad$.numberValue,
                                gasConsumption:
                                    _consumptionGasRoad$.numberValue,
                              );
                            } else {
                              _generalResultCubit.calculate(
                                gasPrice: _gasPrice$.numberValue,
                                ethanolPrice: _ethanolPrice$.numberValue,
                              );
                            }
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      _showConsumption
                          ? Row(
                              children: [
                                Expanded(
                                  child: BlocBuilder<ConsumptionResultCubit,
                                      ConsumptionResultState>(
                                    bloc: _cityResultCubit,
                                    builder: (_, state) {
                                      if (state.state != null) {
                                        late Color containerColor;
                                        if (state.state ==
                                            FuelRecommendationEnum.Gasoline) {
                                          containerColor = Colors.red;
                                        } else if (state.state ==
                                            FuelRecommendationEnum.Ethanol) {
                                          containerColor = Colors.green;
                                        } else {
                                          containerColor = Colors.transparent;
                                        }
                                        return Container(
                                          color: containerColor,
                                          height: 60,
                                          width: 200,
                                          alignment: Alignment.center,
                                          child: Text(
                                            state.state!.fuelName,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return SizedBox.shrink();
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: BlocBuilder<ConsumptionResultCubit,
                                      ConsumptionResultState>(
                                    bloc: _roadResultCubit,
                                    builder: (_, state) {
                                      if (state.state != null) {
                                        late Color containerColor;
                                        if (state.state ==
                                            FuelRecommendationEnum.Gasoline) {
                                          containerColor = Colors.red;
                                        } else if (state.state ==
                                            FuelRecommendationEnum.Ethanol) {
                                          containerColor = Colors.green;
                                        } else {
                                          containerColor = Colors.transparent;
                                        }
                                        return Container(
                                          color: containerColor,
                                          height: 60,
                                          width: 200,
                                          alignment: Alignment.center,
                                          child: Text(
                                            state.state!.fuelName,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return SizedBox.shrink();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            )
                          : BlocBuilder<ConsumptionResultCubit,
                              ConsumptionResultState>(
                              bloc: _generalResultCubit,
                              builder: (_, state) {
                                if (state.state != null) {
                                  late Color containerColor;
                                  if (state.state ==
                                      FuelRecommendationEnum.Gasoline) {
                                    containerColor = Colors.red;
                                  } else if (state.state ==
                                      FuelRecommendationEnum.Ethanol) {
                                    containerColor = Colors.green;
                                  } else {
                                    containerColor = Colors.transparent;
                                  }
                                  return Container(
                                    color: containerColor,
                                    height: 60,
                                    width: 200,
                                    alignment: Alignment.center,
                                    child: Text(
                                      state.state!.fuelName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                } else {
                                  return SizedBox.shrink();
                                }
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
