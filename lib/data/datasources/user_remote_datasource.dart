import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/request/create_user_request_model.dart';
import '../models/request/user_request_model.dart';
import '../models/response/login_response_model.dart';
import 'auth_local_datasource.dart';

class UserRemoteDatasource {
  Future<Either<String, bool>> checkUser(String email) async {
    final response = await http.post(
      Uri.parse("${dotenv.env["BASE_URL"]}/user/check"),
      headers: {
        'Authorization': 'Bearer ${dotenv.env["TOKEN"]}',
        'Accept': 'application/json',
      },
      body: jsonEncode({"email": email}),
    );

    if (response.statusCode == 200) {
      final valid = jsonDecode(response.body)['valid'];
      return Right(valid);
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }

  Future<Either<String, String>> createUser(
      CreateUserRequestModel model) async {
    final response = await http.post(
      Uri.parse("${dotenv.env["BASE_URL"]}/user"),
      headers: {
        'Authorization': 'Bearer ${dotenv.env["TOKEN"]}',
        'Accept': 'application/json',
      },
      body: model.toJson(),
    );

    if (response.statusCode == 201) {
      final message = jsonDecode(response.body)['message'];
      return Right(message);
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }

  Future<Either<String, UserModel>> getUserEmail(String email) async {
    final response = await http.get(
      Uri.parse("${dotenv.env["BASE_URL"]}/user/$email"),
      headers: {
        'Authorization': 'Bearer ${dotenv.env["TOKEN"]}',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return Right(UserModel.fromMap(data));
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }

  Future<Either<String, UserModel>> updateGoogleId(
    String googleId,
    String id,
  ) async {
    final response = await http.put(
      Uri.parse("${dotenv.env["BASE_URL"]}/user/google-id/$id"),
      headers: {
        'Authorization': 'Bearer ${dotenv.env["TOKEN"]}',
        'Accept': 'application/json',
      },
      body: jsonEncode({"google_id": googleId}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return Right(UserModel.fromMap(data));
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }

  Future<Either<String, UserModel>> updateUser(
    UserRequestModel model,
  ) async {
    final userData = await AuthLocalDatasource().getUserData();
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${userData?.data?.token}',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.put(
      Uri.parse("${dotenv.env["BASE_URL"]}/user/${userData?.data?.user?.id}"),
      headers: headers,
      body: model.toJson(),
    );
    log(model.toJson());
    log(response.statusCode.toString());
    log(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body)['data'];
      return Right(UserModel.fromMap(data));
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }

  Future<Either<String, UserModel>> updateAgreePrivacyPolicy(
      String id,
      ) async {
    final response = await http.put(
      Uri.parse("${dotenv.env["BASE_URL"]}/user/agree-privacy-policy/$id"),
      headers: {
        'Authorization': 'Bearer ${dotenv.env["TOKEN"]}',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        "agreed_privacy_policy": true,
        "privacy_policy_agreed_at":DateTime.now().toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return Right(UserModel.fromMap(data));
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }
  
}
