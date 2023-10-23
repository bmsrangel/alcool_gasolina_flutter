import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class EntradasWidget extends StatelessWidget {
  final String combustivel;
  final MoneyMaskedTextController controller;
  final Color cor;
  final FocusNode focusController;
  const EntradasWidget({
    Key? key,
    required this.combustivel,
    required this.controller,
    required this.cor,
    required this.focusController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 70,
          child: Text(
            "Valor\n$combustivel",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller,
            focusNode: focusController,
            maxLines: 1,
            keyboardType: TextInputType.number,
            cursorColor: cor,
            decoration: InputDecoration(
              hintText: "Preço $combustivel",
              hoverColor: cor,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: cor),
              ),
            ),
          ),
        )
      ],
    );
  }
}
