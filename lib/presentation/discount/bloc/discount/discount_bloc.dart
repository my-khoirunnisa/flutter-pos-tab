// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_pos_tab_custom/data/datasource/discount_remote_datasource.dart';

import '../../../../data/model/discount_response_model.dart';

part 'discount_bloc.freezed.dart';
part 'discount_event.dart';
part 'discount_state.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  final DiscountRemoteDatasource discountRemoteDatasource;
  DiscountBloc(
    this.discountRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetDiscounts>((event, emit) async {
      emit(const _Loading());
      final result = await discountRemoteDatasource.getDiscounts();
      result.fold(
        (error) => emit(_Error(error)),
        (success) => emit(_Loaded(success.data!)),
      );
    });
  }
}
