import 'package:dartz/dartz.dart';
import 'package:flutter_pos_tab_custom/core/constants/variables.dart';
import 'package:flutter_pos_tab_custom/data/datasource/auth_local_datasource.dart';
import 'package:flutter_pos_tab_custom/data/model/product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getProducts() async {
    final url = Uri.parse('${Variables.baseUrl}/api/api-products');
    final authData = await AuthLocalDatasource().getAuthData();
    final header = {
      'Authorization': 'Bearer ${authData.token}',
      'Accept': 'application/json',
      "Keep-Alive": "timeout=5, max=1",
      'Accept-Encoding': 'gzip, deflate, br',
    };
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get products');
    }
  }
}
