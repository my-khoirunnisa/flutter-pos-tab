import 'package:dartz/dartz.dart';
import 'package:flutter_pos_tab_custom/data/datasource/auth_local_datasource.dart';
import 'package:flutter_pos_tab_custom/presentation/home/models/order_model.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';

class OrderRemoteDatasource {
  Future<bool> saveOrder(OrderModel orderModel) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final header = {
      'Authorization': 'Bearer ${authData.token}',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/save-order'),
      body: orderModel.toJson(),
      headers: header,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
