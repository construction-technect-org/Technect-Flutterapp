import 'dart:convert';
import 'dart:io';

import 'package:construction_technect/app/core/apiManager/api_exception.dart';
import 'package:construction_technect/app/core/apiManager/error_model.dart';
import 'package:construction_technect/app/core/utils/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  // Local
  // static const String baseUrl = "http://192.168.1.66:3000/api/";
  // Live
  static const String baseUrl = "http://43.205.117.97/api/";

  /// POST method for JSON body requests
  Future<dynamic> postObject({required String url, required Object body}) async {
    try {
      final headers = {'Content-Type': 'application/json'};

      Get.printInfo(info: '🌐 API POST Request:');
      Get.printInfo(info: '   URL: ${baseUrl + url}');
      Get.printInfo(info: '   Headers: $headers');
      Get.printInfo(info: '   Body: $body');

      final request = http.Request('POST', Uri.parse(baseUrl + url));
      request.body = json.encode(body);
      request.headers.addAll(headers);

      final http.StreamedResponse response = await request.send();

      Get.printInfo(info: '📡 API Response:');
      Get.printInfo(info: '   Status: ${response.statusCode}');
      Get.printInfo(info: '   Headers: ${response.headers}');

      final map = _returnResponse(response);

      Get.printInfo(info: '✅ Parsed Response: $map');
      return map;
    } on SocketException {
      Get.printInfo(info: '❌ Network Error: No Internet Connection');
      SnackBars.errorSnackBar(content: 'No Internet Connection');
      throw FetchDataException('No Internet connection');
    } catch (e) {
      Get.printInfo(info: '❌ Unexpected Error: $e');
      SnackBars.errorSnackBar(content: 'Unexpected error occurred');
      throw FetchDataException('Unexpected error: $e');
    }
  }

  /// Handle HTTP response and return parsed data
  dynamic _returnResponse(http.StreamedResponse response) async {
    final responseString = await response.stream.bytesToString();

    Get.printInfo(info: '📋 Raw Response Body: $responseString');

    switch (response.statusCode) {
      case 200:
        final responseJson = json.decode(responseString);
        return responseJson;

      case 201:
        final Map responseJson = json.decode(responseString);
        if (responseJson['code'] == "0") {
          SnackBars.errorSnackBar(content: responseJson['message']);
          throw BadRequestException(responseJson['message']);
        }
        return responseJson;

      case 400:
        SnackBars.errorSnackBar(
          content:
              ErrorModel.fromJson(json.decode(responseString)).message ?? 'Bad Request',
        );
        throw BadRequestException(
          ErrorModel.fromJson(json.decode(responseString)).message ?? 'Bad Request',
        );

      case 401:
        SnackBars.errorSnackBar(
          content:
              ErrorModel.fromJson(json.decode(responseString)).message ?? 'Unauthorized',
        );
        throw BadRequestException(
          ErrorModel.fromJson(json.decode(responseString)).message ?? 'Unauthorized',
        );

      case 403:
        SnackBars.errorSnackBar(
          content:
              ErrorModel.fromJson(json.decode(responseString)).message ?? 'Forbidden',
        );
        throw UnauthorisedException(
          ErrorModel.fromJson(json.decode(responseString)).message ?? 'Forbidden',
        );

      case 404:
        SnackBars.errorSnackBar(
          content:
              ErrorModel.fromJson(json.decode(responseString)).message ?? 'Not Found',
        );
        throw UnauthorisedException(
          ErrorModel.fromJson(json.decode(responseString)).message ?? 'Not Found',
        );

      case 409:
        SnackBars.errorSnackBar(
          content:
              ErrorModel.fromJson(json.decode(responseString)).message ??
              'Conflict Error',
        );
        throw BadRequestException(
          ErrorModel.fromJson(json.decode(responseString)).message ?? 'Conflict Error',
        );

      case 500:
      default:
        throw FetchDataException(
          'Error occurred while communicating with Server. Status Code: ${response.statusCode}',
        );
    }
  }
}
