import 'package:alcool_gasolina/app/modules/home/components/entradas/entradas_widget.dart';
import 'package:alcool_gasolina/app/modules/home/components/mostrar_consumo/mostrar_consumo_widget.dart';
import 'package:alcool_gasolina/app/modules/home/home_bloc.dart';
import 'package:alcool_gasolina/app/modules/home/home_module.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc bloc = HomeModule.to.bloc<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.asset(
                "assets/images/tanque-do-carro.jpg",
                height: MediaQuery.of(context).size.height * .2,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
                color: Color(0x99000000),
                colorBlendMode: BlendMode.darken,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 25),
                height: MediaQuery.of(context).size.height * .2,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Etanol ou Gasolina?",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.kanit(
                    textStyle: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    EntradasWidget(
                      combustivel: "Gasolina",
                      controller: bloc.gasolina$,
                      focusController: bloc.focusGasolina$,
                      cor: Colors.red,
                    ),
                    SizedBox(height: 15),
                    EntradasWidget(
                      combustivel: "Etanol",
                      controller: bloc.etanol$,
                      focusController: bloc.focusEtanol$,
                      cor: Colors.green,
                    ),
                    SizedBox(height: 15),
                    MostrarConsumoWidget(),
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
                      onPressed: bloc.calcularResultado,
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: <Widget>[
                        StreamBuilder<String>(
                          initialData: "",
                          stream: bloc.outResultado,
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              String resultado = snapshot.data!;
                              Color corContainer;
                              if (resultado == "Gasolina") {
                                corContainer = Colors.red;
                              } else if (resultado == "Etanol") {
                                corContainer = Colors.green;
                              } else {
                                corContainer = Colors.transparent;
                              }
                              return Container(
                                color: corContainer,
                                height: 60,
                                width: 200,
                                alignment: Alignment.center,
                                child: Text(
                                  snapshot.data!,
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
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
