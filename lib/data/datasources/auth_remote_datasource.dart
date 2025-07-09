import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/response/login_response_model.dart';
import 'auth_local_datasource.dart';

class AuthRemoteDatasource {
  Future<Either<String, LoginResponseModel>> login(
      String email, String password) async {
    final response = await http.post(
      Uri.parse("${dotenv.env['BASE_URL']}/api/login"),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
    log("Status Code: ${response.statusCode}");
    log("Token: ${response.body}");
    if (response.statusCode == 200) {
      return Right(LoginResponseModel.fromMap(jsonDecode(response.body)));
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }

  Future<Either<String, String>> googleLogin(
      String idToken,
      ) async {
    final response = await http.post(
      Uri.parse("${dotenv.env['BASE_URL']}/api/google-login"),
      headers: {
        'Accept': 'application/json',
      },
      body: jsonEncode({
        "id_token": idToken,
      }),
    );
    log("Status Code: ${response.statusCode}");
    log("Token: ${response.body}");
    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];
      return Right(token);
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }

  Future<Either<String, String>> logout() async {
    final response = await http.post(
      Uri.parse("${dotenv.env['BASE_URL']}/api/logout"),
      headers: {
        'Authorization': 'Bearer ${dotenv.env['TOKEN']}',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    log("Status Code: ${response.statusCode}");
    log("Token: ${response.body}");

    if (response.statusCode == 200) {
      final message = jsonDecode(response.body)['message'];
      return Right(message);
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }

  Future<Either<String, LoginResponseModel>> loginGoogle(String idToken) async {
    final response = await http.post(
      Uri.parse('${dotenv.env['BASE_URL']}/api/login/google'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'id_token': idToken}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Right(LoginResponseModel.fromMap(jsonDecode(response.body)));
    } else {
      return Left(jsonDecode(response.body)['message']);
    }
  }

  Future<Either<String, UserModel>> updateOneSignalToken(
      String oneSignalToken) async {
    final userData = await AuthLocalDatasource().getUserData();
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${userData?.data?.token}',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.put(
      Uri.parse(
          "${dotenv.env['BASE_URL']}/api/update-token/${userData?.data?.user?.id}"),
      headers: headers,
      body: jsonEncode({"one_signal_token": oneSignalToken}),
    );

    log("URL: ${response.request!.url}");
    log("Status Code: ${response.statusCode}");
    log("Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return Right(UserModel.fromMap(data));
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }
}
