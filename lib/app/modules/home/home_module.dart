import 'package:alcool_gasolina/app/app_module.dart';
import 'package:alcool_gasolina/app/modules/home/home_bloc.dart';
import 'package:alcool_gasolina/app/shared/services/local_storage_service.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:alcool_gasolina/app/modules/home/home_page.dart';

class HomeModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => HomeBloc(
            localStorageService: AppModule.to.get<LocalStorageService>())),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => HomePage();

  static Inject get to => Inject<HomeModule>.of();
}
