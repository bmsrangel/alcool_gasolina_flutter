import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class FuelPriceWidget extends StatelessWidget {
  const FuelPriceWidget({
    Key? key,
    required this.fuel,
    required this.controller,
    required this.color,
  }) : super(key: key);
  final String fuel;
  final MoneyMaskedTextController controller;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 1,
      keyboardType: TextInputType.number,
      cursorColor: color,
      decoration: InputDecoration(
        floatingLabelStyle: MaterialStateTextStyle.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return TextStyle(color: color);
          } else {
            return TextStyle();
          }
        }),
        labelText: fuel,
        focusColor: color,
        hoverColor: color,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: color),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Campo obrigatório';
        } else if (controller.numberValue <= 0) {
          return 'Valor inválido';
        } else {
          return null;
        }
      },
    );
  }
}
