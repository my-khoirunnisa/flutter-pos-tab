// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_pos_tab_custom/data/datasource/discount_remote_datasource.dart';

part 'delete_discount_bloc.freezed.dart';
part 'delete_discount_event.dart';
part 'delete_discount_state.dart';

class DeleteDiscountBloc
    extends Bloc<DeleteDiscountEvent, DeleteDiscountState> {
  final DiscountRemoteDatasource discountRemoteDatasource;
  DeleteDiscountBloc(
    this.discountRemoteDatasource,
  ) : super(const _Initial()) {
    on<_DeleteDiscount>((event, emit) async {
      emit(const _Loading());
      final result = await discountRemoteDatasource.deleteDiscount(event.id);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
