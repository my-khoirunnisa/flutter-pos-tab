import 'package:dartz/dartz.dart';
import 'package:flutter_pos_tab_custom/core/constants/variables.dart';
import 'package:flutter_pos_tab_custom/data/datasource/auth_local_datasource.dart';
import 'package:flutter_pos_tab_custom/data/model/auth_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    final url = Uri.parse('${Variables.baseUrl}/api/login');
    final response = await http.post(url, body: {
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to login');
    }
  }

  Future<Either<String, bool>> logout() async {
    final url = Uri.parse('${Variables.baseUrl}/api/logout');
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(url, headers: {
      'Authorization': 'Bearer ${authData.token}',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      return const Right(true);
    } else {
      return const Left('Failed to logout');
    }
  }
}
