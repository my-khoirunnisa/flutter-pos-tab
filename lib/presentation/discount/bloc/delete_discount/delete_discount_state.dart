part of 'delete_discount_bloc.dart';

@freezed
class DeleteDiscountState with _$DeleteDiscountState {
  const factory DeleteDiscountState.initial() = _Initial;
  const factory DeleteDiscountState.loading() = _Loading;
  const factory DeleteDiscountState.success() = _Success;
  const factory DeleteDiscountState.error(String message) = _Error;
}
