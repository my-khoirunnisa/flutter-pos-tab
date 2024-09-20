// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_pos_tab_custom/data/datasource/product_local_datasource.dart';

import '../../../home/models/order_model.dart';

part 'transaction_report_bloc.freezed.dart';
part 'transaction_report_event.dart';
part 'transaction_report_state.dart';

class TransactionReportBloc
    extends Bloc<TransactionReportEvent, TransactionReportState> {
  final ProductLocalDatasource productLocalDatasource;
  TransactionReportBloc(
    this.productLocalDatasource,
  ) : super(const _Initial()) {
    on<_GetReport>((event, emit) async {
      emit(const _Loading());
      final result = await productLocalDatasource.getAllOrder(
        event.startDate,
        event.endDate,
      );
      emit(_Loaded(result));
    });
  }
}
