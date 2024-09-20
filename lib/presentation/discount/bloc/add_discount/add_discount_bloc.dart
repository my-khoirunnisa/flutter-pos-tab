// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_pos_tab_custom/data/datasource/discount_remote_datasource.dart';

part 'add_discount_bloc.freezed.dart';
part 'add_discount_event.dart';
part 'add_discount_state.dart';

class AddDiscountBloc extends Bloc<AddDiscountEvent, AddDiscountState> {
  final DiscountRemoteDatasource discountRemoteDatasource;
  AddDiscountBloc(
    this.discountRemoteDatasource,
  ) : super(const _Initial()) {
    on<_AddDiscount>((event, emit) async {
      emit(const _Loading());
      final result = await discountRemoteDatasource.addDiscount(
          event.name, event.description, event.value);
      result.fold(
        (error) => emit(_Error(error)),
        (success) => emit(const _Success()),
      );
    });
  }
}
