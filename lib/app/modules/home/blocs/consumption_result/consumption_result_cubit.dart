import 'package:alcool_gasolina/app/modules/home/enums/fuel_recommendation_enum.dart';
import 'package:alcool_gasolina/app/modules/home/utils/calculator_util.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'consumption_result_state.dart';

class ConsumptionResultCubit extends Cubit<ConsumptionResultState> {
  ConsumptionResultCubit() : super(ConsumptionResultState());

  Future<void> calculate({
    required double gasPrice,
    required double ethanolPrice,
    double? gasConsumption,
    double? ethanolConsumption,
  }) async {
    final priceIndex = CalculatorUtil.calculatePriceIndex(
      gasPrice: gasPrice,
      ethanolPrice: ethanolPrice,
    );
    final result = CalculatorUtil.analyseComsumption(
      priceIndex: priceIndex,
      referenceIndex: 0.7,
      gasConsumption: gasConsumption,
      ethanolConsumption: ethanolConsumption,
    );
    emit(
      state.copyWith(
        state: result,
      ),
    );
  }
}
