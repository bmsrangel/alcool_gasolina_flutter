import 'package:alcool_gasolina/app/modules/home/enums/fuel_recommendation_enum.dart';

class CalculatorUtil {
  static double calculatePriceIndex({
    required double gasPrice,
    required double ethanolPrice,
  }) {
    double result;

    if (gasPrice > 0.0 && ethanolPrice > 0.0) {
      result = ethanolPrice / gasPrice;
      return result;
    } else {
      throw FormatException(
        'An invalid value was informed. Please, check your inputs',
      );
    }
  }

  static FuelRecommendationEnum analyseComsumption({
    required double priceIndex,
    required double referenceIndex,
    double? gasConsumption,
    double? ethanolConsumption,
  }) {
    late double usedReferenceIndex;

    if (gasConsumption != null &&
        gasConsumption > 0 &&
        ethanolConsumption != null &&
        ethanolConsumption > 0) {
      usedReferenceIndex = ethanolConsumption / gasConsumption;
    } else {
      usedReferenceIndex = referenceIndex;
    }

    if (priceIndex < usedReferenceIndex) {
      return FuelRecommendationEnum.Ethanol;
    } else {
      return FuelRecommendationEnum.Gasoline;
    }
  }
}
