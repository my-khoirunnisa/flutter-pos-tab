part of 'update_discount_bloc.dart';

@freezed
class UpdateDiscountEvent with _$UpdateDiscountEvent {
  const factory UpdateDiscountEvent.started() = _Started;
  const factory UpdateDiscountEvent.updateDiscount({
    required String name,
    required String description,
    required int value,
    required int id,
  }) = _UpdateDiscount;
}
