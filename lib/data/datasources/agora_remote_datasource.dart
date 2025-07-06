import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';

class AgoraRemoteDatasource{
  Future<Either<String, AgoraResponseModel>> getAgoraCalls() async{
    final userData = await AuthLocalDatasource().getUserData();
    final response = await http.get(
  Uri.parse('${Variables.baseUrl}/api/agora-calls'),
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
}