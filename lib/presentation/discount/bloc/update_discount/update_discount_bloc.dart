// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_pos_tab_custom/data/datasource/discount_remote_datasource.dart';

part 'update_discount_bloc.freezed.dart';
part 'update_discount_event.dart';
part 'update_discount_state.dart';

class UpdateDiscountBloc
    extends Bloc<UpdateDiscountEvent, UpdateDiscountState> {
  final DiscountRemoteDatasource discountRemoteDatasource;
  UpdateDiscountBloc(
    this.discountRemoteDatasource,
  ) : super(const _Initial()) {
    on<_UpdateDiscount>((event, emit) async {
      final result = await discountRemoteDatasource.updateDiscount(
          event.name, event.description, event.value, event.id);
      result.fold(
        (error) => emit(_Error(error)),
        (success) => emit(const _Success()),
      );
    });
  }
}
