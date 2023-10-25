import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}
