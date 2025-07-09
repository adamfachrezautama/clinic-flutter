import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_clinicapp/data/models/request/agora_request_model.cart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/response/agora_response_model.dart';
import '../models/response/token_model.dart';
import 'auth_local_datasource.dart';

class AgoraRemoteDatasource{
  Future<Either<String, AgoraResponseModel>> getAgoraCalls() async{
    final userData = await AuthLocalDatasource().getUserData();
    final response = await http.get(
  Uri.parse('${dotenv.env['BASE_URL']}/api/agora-calls'),
  headers: {
    'Authorization' : 'Bearer ${userData?.data?.token}',
  'Accept' : 'application/json',
  },
  );
    if(response.statusCode == 200){
      return Right(AgoraResponseModel.fromMap(jsonDecode(response.body)));
  }else{
      final message = jsonDecode(response.body)['message'];
  return Left(message);
    }
  }

  Future<Either<String, String>> addAgoraCall(AgoraRequestModel model) async{
    final userData = await AuthLocalDatasource().getUserData();
    final response = await http.post(
      Uri.parse('${dotenv.env['BASE_URL']}/api/agora-call'),
      headers:{
        'Authorization': 'Bearer ${userData?.data?.token}',
        'Accept': 'application/json',
      },
      body: model.toJson(),
    );

    if(response.statusCode == 200 || response.statusCode == 201){
      final message = jsonDecode(response.body)['message'];
      return Right(message);
    }else{
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }

  Future<Either<String, TokenModel>> getToken(String channelName) async {
    final response = await http.get(
      Uri.parse('${dotenv.env['BASE_URL']}/api/agora/token/$channelName'),
    );
    if(response.statusCode == 200){
      final jsonData = jsonDecode(response.body);
      final token = jsonData['token'];
      final uid = jsonData['uid'];
      log('token: $token');
      log('uidL $uid');
      return Right(
        TokenModel(
          token: token,
          uid: uid,
        ),
      );
    }else{
      return Left(response.body);
    }
  }
}