part of 'consumption_result_cubit.dart';

class ConsumptionResultState extends Equatable {
  const ConsumptionResultState({
    this.state,
    this.error,
  });

  final FuelRecommendationEnum? state;
  final String? error;

  ConsumptionResultState copyWith({
    FuelRecommendationEnum? state,
    String? error,
  }) {
    return ConsumptionResultState(
      state: state ?? this.state,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [state, error];
}
