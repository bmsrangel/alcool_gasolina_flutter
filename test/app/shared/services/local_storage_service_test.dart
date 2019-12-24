import 'package:flutter_test/flutter_test.dart';

import 'package:alcool_gasolina/app/shared/services/local_storage_service.dart';

void main() {
  LocalStorageService service;

  setUp(() {
    service = LocalStorageService();
  });

  group('LocalStorageService Test', () {
    test("First Test", () {
      expect(service, isInstanceOf<LocalStorageService>());
    });
  });
}
