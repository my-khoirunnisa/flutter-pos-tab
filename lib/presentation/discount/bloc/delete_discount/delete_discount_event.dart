part of 'delete_discount_bloc.dart';

@freezed
class DeleteDiscountEvent with _$DeleteDiscountEvent {
  const factory DeleteDiscountEvent.started() = _Started;
  const factory DeleteDiscountEvent.deleteDiscount(int id) = _DeleteDiscount;
}
