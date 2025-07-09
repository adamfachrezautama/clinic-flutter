import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_clinicapp/data/models/response/specialitation_response_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'auth_local_datasource.dart';

class SpecialitationRemoteDatasource {
  Future<Either<String, SpecialitationModel>> getSpecialations() async {
    final userData = await AuthLocalDatasource().getUserData();
    final response = await http.get(
      Uri.parse("${dotenv.env["BASE_URL"]}/api/specialists"),
      headers: {
        'Authorization': 'Bearer ${userData?.data?.token}',
        'Accept': 'application/json',
      },
    );
    log("Status Code: ${response.statusCode}");
    log("Body: ${response.body}");
    if (response.statusCode == 200) {
      return Right(SpecialitationModel.fromJson(response.body));
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }
}
