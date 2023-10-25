import 'package:alcool_gasolina/app/shared/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final LocalStorageService _localStorageService;

  @override
  void initState() {
    super.initState();
    _localStorageService = Modular.get<LocalStorageService>();
    _localStorageService.init().then((_) => Modular.to.navigate('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
