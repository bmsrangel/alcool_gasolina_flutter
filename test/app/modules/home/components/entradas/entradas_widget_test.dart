import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:alcool_gasolina/app/modules/home/components/entradas/entradas_widget.dart';

main() {
  testWidgets('EntradasWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(EntradasWidget(
      combustivel: "Gasolina",
      cor: Colors.red,
      controller: MoneyMaskedTextController(),
      focusController: FocusNode(),
    )));
    final textFinder = find.text('Entradas');
    expect(textFinder, findsOneWidget);
  });
}
