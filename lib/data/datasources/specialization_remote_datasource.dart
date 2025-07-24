import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

import '../models/response/specialization_response_model.dart';
import 'auth_local_datasource.dart';

class SpecializationRemoteDatasource {
  get specialistId => null;

  Future<Either<String, SpecializationResponseModel>> getSpecialations() async {
    final userData = await AuthLocalDatasource().getUserData();
    final response = await http.get(
      Uri.parse("${dotenv.env["BASE_URL"]}/specializations"),
      headers: {
        'Authorization': 'Bearer ${userData?.data?.token}',
        'Accept': 'application/json',
      },
    );
    log("Status Code: ${response.statusCode}");
    log("Body: ${response.body}");
    if (response.statusCode == 200) {
      return Right(SpecializationResponseModel.fromJson(response.body));
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }
}
