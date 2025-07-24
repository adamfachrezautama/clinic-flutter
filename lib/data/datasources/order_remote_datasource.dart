import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/request/order_request_model.dart';
import '../models/response/create_order_response_model.dart';
import '../models/response/order_response_model.dart';
import 'auth_local_datasource.dart';

class OrderRemoteDatasource {
  Future<Either<String, OrderResponseModel>> getOrdersByClinic() async {
    final userData = await AuthLocalDatasource().getUserData();
    final response = await http.get(
      Uri.parse(
          '${dotenv.env["BASE_URL"]}/orders/clinic/${userData?.data?.user?.clinicId}'),
      headers: {
        'Authorization': 'Bearer ${userData?.data?.token}',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Right(OrderResponseModel.fromMap(jsonDecode(response.body)));
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }

  Future<Either<String, CreateOrderResponseModel>> createOrder(
      OrderRequestModel model) async {
    final userData = await AuthLocalDatasource().getUserData();
    final response = await http.post(
      Uri.parse('${dotenv.env["BASE_URL"]}/orders'),
      headers: {
        'Authorization': 'Bearer ${userData?.data?.token}',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: model.toJson(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Right(CreateOrderResponseModel.fromMap(jsonDecode(response.body)));
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }

  // Future<Either<String, SummaryResponseModel>> getSummaryClinic() async {
  //   const String clinicId = "1";
  //   final response = await http.get(
  //     Uri.parse('${Variables.baseUrl}/orders/summary/$clinicId'),
  //     headers: {
  //       'Authorization': 'Bearer ${Variables.token}',
  //       'Accept': 'application/json',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     return Right(SummaryResponseModel.fromMap(jsonDecode(response.body)));
  //   } else {
  //     final message = jsonDecode(response.body)['message'];
  //     return Left(message);
  //   }
  // }

  Future<Either<String, OrderResponseModel>> getOrdersByPatient() async {
    final userData = await AuthLocalDatasource().getUserData();
    final response = await http.get(
      Uri.parse(
          '${dotenv.env["BASE_URL"]}/orders/patient/${userData?.data?.user?.id}'),
      headers: {
        'Authorization': 'Bearer ${userData?.data?.token}',
        'Accept': 'application/json',
      },
    );
    log("Status Code: ${response.statusCode}");
    log("Status Code: ${response.body}");
    if (response.statusCode == 200) {
      return Right(OrderResponseModel.fromMap(jsonDecode(response.body)));
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }

  Future<Either<String, OrderResponseModel>> getOrdersByDoctor() async {
    final userData = await AuthLocalDatasource().getUserData();
    final response = await http.get(
      Uri.parse(
          '${dotenv.env["BASE_URL"]}/orders/doctor/${userData?.data?.user?.id}'),
      headers: {
        'Authorization': 'Bearer ${userData?.data?.token}',
        'Accept': 'application/json',
      },
    );
    log("Status Code: ${response.statusCode}");
    log("Status Code: ${response.body}");
    if (response.statusCode == 200) {
      return Right(OrderResponseModel.fromMap(jsonDecode(response.body)));
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }

  Future<Either<String, OrderResponseModel>> getOrdersByDoctorQuery(
      String service, String statusService) async {
    final userData = await AuthLocalDatasource().getUserData();
    final response = await http.get(
      Uri.parse(
          '${dotenv.env["BASE_URL"]}/orders/doctor/${userData?.data?.user?.id}/$service/$statusService'),
      headers: {
        'Authorization': 'Bearer ${userData?.data?.token}',
        'Accept': 'application/json',
      },
    );
    log("URL: ${response.request!.url}");
    log("Status Code: ${response.statusCode}");
    log("Status Code: ${response.body}");
    if (response.statusCode == 200) {
      return Right(OrderResponseModel.fromMap(jsonDecode(response.body)));
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }

  Future<Either<String, String>> xenditCallback(
      String externalId, String status) async {
    final response = await http.post(
      Uri.parse('${dotenv.env["BASE_URL"]}/orders/xendit-callback'),
      headers: {
        // 'Authorization': 'Bearer ${Variables.token}',
        'Accept': 'application/json',
        'x-callback-token': '${dotenv.env["CALL_BACK_TOKEN"]}',
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          "external_id": externalId,
          "status": status,
          "status_service": "Active"
        },
      ),
    );

    log("URL: ${response.request!.url}");
    log("Request: ${response.request!.headers} ");
    log("Status Code Callback: ${response.statusCode}");
    log("Status Body Callback: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return const Right("Success");
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }
}
