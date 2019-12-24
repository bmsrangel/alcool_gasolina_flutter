import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:alcool_gasolina/app/modules/home/components/mostrar_consumo/mostrar_consumo_widget.dart';

main() {
  testWidgets('MostrarConsumoWidget has message', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(MostrarConsumoWidget()));
    final textFinder = find.text('MostrarConsumo');
    expect(textFinder, findsOneWidget);
  });
}
