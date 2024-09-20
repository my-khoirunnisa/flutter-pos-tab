part of 'update_discount_bloc.dart';

@freezed
class UpdateDiscountState with _$UpdateDiscountState {
  const factory UpdateDiscountState.initial() = _Initial;
  const factory UpdateDiscountState.loading() = _Loading;
  const factory UpdateDiscountState.success() = _Success;
  const factory UpdateDiscountState.error(String message) = _Error;
}
