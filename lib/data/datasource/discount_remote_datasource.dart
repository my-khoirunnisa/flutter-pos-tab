import 'package:dartz/dartz.dart';
import 'package:flutter_pos_tab_custom/core/constants/variables.dart';
import 'package:flutter_pos_tab_custom/data/datasource/auth_local_datasource.dart';
import 'package:flutter_pos_tab_custom/data/model/discount_response_model.dart';
import 'package:http/http.dart' as http;

class DiscountRemoteDatasource {
  Future<Either<String, DiscountResponseModel>> getDiscounts() async {
    final url = Uri.parse('${Variables.baseUrl}/api/api-discounts');
    final authData = await AuthLocalDatasource().getAuthData();
    final header = {
      'Authorization': 'Bearer ${authData.token}',
      'Accept': 'application/json',
    };
    final response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      return Right(DiscountResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get dicounts');
    }
  }

  Future<Either<String, bool>> addDiscount(
    String name,
    String description,
    int value,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/api-discounts');
    final authData = await AuthLocalDatasource().getAuthData();
    final header = {
      'Authorization': 'Bearer ${authData.token}',
      'Accept': 'application/json',
    };
    final body = {
      'name': name,
      'description': description,
      'value': value.toString(),
    };
    final response = await http.post(url, headers: header, body: body);
    if (response.statusCode == 200) {
      return const Right(true);
    } else {
      return const Left('Failed to add discount');
    }
  }

  Future<Either<String, bool>> updateDiscount(
    String name,
    String description,
    int value,
    int id,
  ) async {
    final url = Uri.parse('${Variables.baseUrl}/api/api-discounts/$id');
    final authData = await AuthLocalDatasource().getAuthData();
    final header = {
      'Authorization': 'Bearer ${authData.token}',
      'Accept': 'application/json',
    };
    final body = {
      'name': name,
      'description': description,
      'value': value.toString(),
    };
    final response = await http.put(url, headers: header, body: body);
    if (response.statusCode == 200) {
      return const Right(true);
    } else {
      return const Left('Failed to add discount');
    }
  }

  Future<Either<String, String>> deleteDiscount(int id) async {
    final url = Uri.parse('${Variables.baseUrl}/api/api-discounts/$id');
    final authData = await AuthLocalDatasource().getAuthData();
    final header = {
      'Authorization': 'Bearer ${authData.token}',
      'Accept': 'application/json',
    };
    final response = await http.delete(url, headers: header);
    if (response.statusCode == 200) {
      return const Right('Discount deleted!');
    } else {
      return const Left('Failed to delete discount');
    }
  }
}
