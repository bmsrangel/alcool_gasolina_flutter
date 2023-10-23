import 'package:alcool_gasolina/app/modules/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MostrarConsumoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeBloc bloc = Modular.get<HomeBloc>();

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text("Incluir consumo do veículo"),
            StreamBuilder<bool>(
              stream: bloc.outMostrarConsumo,
              initialData: false,
              builder: (_, snapshot) {
                return Switch(
                  value: snapshot.data ?? false,
                  onChanged: (bool value) {
                    bloc.inMostrarConsumo.add(value);
                  },
                );
              },
            ),
          ],
        ),
        StreamBuilder(
          initialData: false,
          stream: bloc.outMostrarConsumo,
          builder: (_, snapshot) {
            return snapshot.data ?? false ? consumo(bloc) : Container();
          },
        )
      ],
    );
  }

  Widget consumo(HomeBloc bloc) {
    return Column(
      children: <Widget>[
        entradasConsumo("Gasolina", bloc.consumoGasolina$,
            bloc.focusconsumoGasolina$, Colors.red),
        entradasConsumo("Etanol", bloc.consumoEtanol$, bloc.focusConsumoEtanol$,
            Colors.green),
      ],
    );
  }

  Widget entradasConsumo(
    String combustivel,
    MoneyMaskedTextController controller,
    FocusNode focusController,
    Color cor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Consumo\n$combustivel",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusController,
              cursorColor: cor,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Consumo $combustivel",
                  focusedBorder:
                      UnderlineInputBorder(borderSide: BorderSide(color: cor))),
            ),
          )
        ],
      ),
    );
  }
}
