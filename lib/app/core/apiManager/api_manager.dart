import 'dart:convert';
import 'dart:io';

import 'package:construction_technect/app/core/apiManager/api_exception.dart';
import 'package:construction_technect/app/core/apiManager/error_model.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/widgets/error_sheet.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiManager {
  // Local
  // static const String baseUrl = "http://localhost:3000/api/";
  // Live
  static const String baseUrl = "https://constructiontechnect.com/api/";

  /// Check if response contains invalid/expired token
  void _checkTokenValidity(dynamic response) {
    if (response is Map<String, dynamic>) {
      final success = response['success'];
      final message = response['message']?.toString();

      Get.printInfo(info: '🔍 Token Validation Check:');
      Get.printInfo(info: '   Success: $success');
      Get.printInfo(info: '   Message: $message');

      // Check for exact message "Invalid or expired token" or similar variations
      if (success == false &&
          (message == "Invalid or expired token" ||
              message?.toLowerCase().contains("invalid") == true &&
                  message?.toLowerCase().contains("expired") == true &&
                  message?.toLowerCase().contains("token") == true)) {
        Get.printInfo(info: '🔑 Invalid/Expired Token Detected: $message');
        _handleTokenExpiry();
      }
    }
  }

  /// Handle token expiry by clearing data and redirecting to login
  void _handleTokenExpiry() {
    // Clear user data and token
    myPref.logout();

    // Show message to user
    SnackBars.errorSnackBar(content: 'Session expired. Please login again.');

    // Navigate to login screen
    Get.offAllNamed(Routes.LOGIN);
  }

  /// GET method for requests with authorization header
  /// GET method with optional query parameters
  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? params, // ✅ optional query params
  }) async {
    try {
      // Build full URL with query parameters
      final uri = Uri.parse(
        baseUrl + url,
      ).replace(queryParameters: params?.map((key, value) => MapEntry(key, value.toString())));

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${myPref.getToken()}',
      };

      Get.printInfo(info: '🌐 API GET Request:');
      Get.printInfo(info: '   URL: $uri');
      Get.printInfo(info: '   Headers: $headers');

      final request = http.Request('GET', uri);
      request.headers.addAll(headers);

      final http.StreamedResponse response = await request.send();
      final map = await _returnResponse(response);

      // Check for invalid/expired token
      _checkTokenValidity(map);

      Get.printInfo(info: '✅ Parsed Response: $map');
      return map;
    } on SocketException {
      Get.printInfo(info: '❌ Network Error: No Internet Connection');
      SnackBars.errorSnackBar(content: 'No Internet Connection');
      throw FetchDataException('No Internet connection');
    } catch (e) {
      Get.printInfo(info: '❌ Unexpected Error: $e');
      //SnackBars.errorSnackBar(content: 'Unexpected error occurred');
      throw FetchDataException('Unexpected error: $e');
    }
  }

  /// POST method for JSON body requests
  Future<dynamic> postObject({required String url, required Object body}) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${myPref.getToken()}',
      };

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

      final map = await _returnResponse(response);

      // Check for invalid/expired token in response body
      _checkTokenValidity(map);

      Get.printInfo(info: '✅ Parsed Response: $map');
      return map;
    } on SocketException {
      Get.printInfo(info: '❌ Network Error: No Internet Connection');
      SnackBars.errorSnackBar(content: 'No Internet Connection');
      throw FetchDataException('No Internet connection');
    } catch (e) {
      Get.printInfo(info: '❌ Unexpected Error: $e');
      //SnackBars.errorSnackBar(content: 'Unexpected error occurred');
      throw FetchDataException('Unexpected error: $e');
    }
  }

  /// PUT method for JSON body requests
  Future<dynamic> put({required String url}) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${myPref.getToken()}',
      };

      Get.printInfo(info: '🌐 API PUT Request:');
      Get.printInfo(info: '   URL: ${baseUrl + url}');
      Get.printInfo(info: '   Headers: $headers');

      final request = http.Request('PUT', Uri.parse(baseUrl + url));
      request.headers.addAll(headers);

      final http.StreamedResponse response = await request.send();

      Get.printInfo(info: '📡 API Response:');
      Get.printInfo(info: '   Status: ${response.statusCode}');
      Get.printInfo(info: '   Headers: ${response.headers}');

      final map = await _returnResponse(response);

      // Check for invalid/expired token in response body
      _checkTokenValidity(map);

      Get.printInfo(info: '✅ Parsed Response: $map');
      return map;
    } on SocketException {
      Get.printInfo(info: '❌ Network Error: No Internet Connection');
      SnackBars.errorSnackBar(content: 'No Internet Connection');
      throw FetchDataException('No Internet connection');
    } catch (e) {
      Get.printInfo(info: '❌ Unexpected Error: $e');
      //SnackBars.errorSnackBar(content: 'Unexpected error occurred');
      throw FetchDataException('Unexpected error: $e');
    }
  }

  Future<dynamic> putObject({required String url, required Object body}) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${myPref.getToken()}',
      };

      Get.printInfo(info: '🌐 API PUT Request:');
      Get.printInfo(info: '   URL: ${baseUrl + url}');
      Get.printInfo(info: '   Headers: $headers');
      Get.printInfo(info: '   Body: $body');

      final request = http.Request('PUT', Uri.parse(baseUrl + url));
      request.body = json.encode(body);
      request.headers.addAll(headers);

      final http.StreamedResponse response = await request.send();

      Get.printInfo(info: '📡 API Response:');
      Get.printInfo(info: '   Status: ${response.statusCode}');
      Get.printInfo(info: '   Headers: ${response.headers}');

      final map = await _returnResponse(response);

      // Check for invalid/expired token in response body
      _checkTokenValidity(map);

      Get.printInfo(info: '✅ Parsed Response: $map');
      return map;
    } on SocketException {
      Get.printInfo(info: '❌ Network Error: No Internet Connection');
      SnackBars.errorSnackBar(content: 'No Internet Connection');
      throw FetchDataException('No Internet connection');
    } catch (e) {
      Get.printInfo(info: '❌ Unexpected Error: $e');
      //SnackBars.errorSnackBar(content: 'Unexpected error occurred');
      throw FetchDataException('Unexpected error: $e');
    }
  }

  /// POST method for multipart form data requests (file uploads)
  Future<dynamic> postMultipart({
    required String url,
    required Map<String, dynamic> fields,
    Map<String, String>? files,
  }) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(baseUrl + url));

      // Add authorization header
      request.headers['Authorization'] = 'Bearer ${myPref.getToken()}';

      // Add form fields
      fields.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Add files
      if (files != null) {
        for (final entry in files.entries) {
          final file = File(entry.value);
          final fileName = file.path.split('/').last;
          final fileExtension = fileName.split('.').last.toLowerCase();

          // Determine MIME type based on file extension
          String? mimeType;
          switch (fileExtension) {
            case 'pdf':
              mimeType = 'application/pdf';
            case 'jpg':
            case 'jpeg':
              mimeType = 'image/jpeg';
            case 'png':
              mimeType = 'image/png';
            case 'doc':
              mimeType = 'application/msword';
            case 'docx':
              mimeType = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
            default:
              mimeType = 'application/octet-stream';
          }

          request.files.add(
            await http.MultipartFile.fromPath(
              entry.key,
              entry.value,
              filename: fileName,
              contentType: MediaType.parse(mimeType),
            ),
          );
        }
      }

      Get.printInfo(info: '🌐 API POST Multipart Request:');
      Get.printInfo(info: '   URL: ${baseUrl + url}');
      Get.printInfo(info: '   Headers: ${request.headers}');
      Get.printInfo(info: '   Fields: $fields');
      Get.printInfo(info: '   Files: $files');

      final http.StreamedResponse response = await request.send();

      Get.printInfo(info: '📡 API Response:');
      Get.printInfo(info: '   Status: ${response.statusCode}');
      Get.printInfo(info: '   Headers: ${response.headers}');

      final map = await _returnResponse(response);

      // Check for invalid/expired token in response body
      _checkTokenValidity(map);

      Get.printInfo(info: '✅ Parsed Response: $map');
      return map;
    } on SocketException {
      Get.printInfo(info: '❌ Network Error: No Internet Connection');
      SnackBars.errorSnackBar(content: 'No Internet Connection');
      throw FetchDataException('No Internet connection');
    } catch (e) {
      Get.printInfo(info: '❌ Unexpected Error: $e');
      //SnackBars.errorSnackBar(content: 'Unexpected error occurred');
      throw FetchDataException('Unexpected error: $e');
    }
  }

  /// PUT method for multipart form data requests (file uploads)
  Future<dynamic> putMultipart({
    required String url,
    required Map<String, dynamic> fields,
    Map<String, String>? files,
  }) async {
    try {
      final request = http.MultipartRequest('PUT', Uri.parse(baseUrl + url));

      // Add authorization header
      request.headers['Authorization'] = 'Bearer ${myPref.getToken()}';

      // Add form fields
      fields.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // Add files
      if (files != null) {
        for (final entry in files.entries) {
          final file = File(entry.value);
          final fileName = file.path.split('/').last;
          final fileExtension = fileName.split('.').last.toLowerCase();

          // Determine MIME type based on file extension
          String? mimeType;
          switch (fileExtension) {
            case 'pdf':
              mimeType = 'application/pdf';
            case 'jpg':
            case 'jpeg':
              mimeType = 'image/jpeg';
            case 'png':
              mimeType = 'image/png';
            case 'doc':
              mimeType = 'application/msword';
            case 'docx':
              mimeType = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
            default:
              mimeType = 'application/octet-stream';
          }

          request.files.add(
            await http.MultipartFile.fromPath(
              entry.key,
              entry.value,
              filename: fileName,
              contentType: MediaType.parse(mimeType),
            ),
          );
        }
      }

      Get.printInfo(info: '🌐 API PUT Multipart Request:');
      Get.printInfo(info: '   URL: ${baseUrl + url}');
      Get.printInfo(info: '   Headers: ${request.headers}');
      Get.printInfo(info: '   Fields: $fields');
      Get.printInfo(info: '   Files: $files');

      final http.StreamedResponse response = await request.send();

      Get.printInfo(info: '📡 API Response:');
      Get.printInfo(info: '   Status: ${response.statusCode}');
      Get.printInfo(info: '   Headers: ${response.headers}');

      final map = await _returnResponse(response);

      // Check for invalid/expired token in response body
      _checkTokenValidity(map);

      Get.printInfo(info: '✅ Parsed Response: $map');
      return map;
    } on SocketException {
      Get.printInfo(info: '❌ Network Error: No Internet Connection');
      SnackBars.errorSnackBar(content: 'No Internet Connection');
      throw FetchDataException('No Internet connection');
    } catch (e) {
      Get.printInfo(info: '❌ Unexpected Error: $e');
      //SnackBars.errorSnackBar(content: 'Unexpected error occurred');
      throw FetchDataException('Unexpected error: $e');
    }
  }

  /// DELETE method for requests with authorization header
  Future<dynamic> delete({required String url}) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${myPref.getToken()}',
      };

      Get.printInfo(info: '🌐 API DELETE Request:');
      Get.printInfo(info: '   URL: ${baseUrl + url}');
      Get.printInfo(info: '   Headers: $headers');

      final request = http.Request('DELETE', Uri.parse(baseUrl + url));
      request.headers.addAll(headers);

      final http.StreamedResponse response = await request.send();

      Get.printInfo(info: '📡 API Response:');
      Get.printInfo(info: '   Status: ${response.statusCode}');
      Get.printInfo(info: '   Headers: ${response.headers}');

      final map = await _returnResponse(response);

      // Check for invalid/expired token in response body
      _checkTokenValidity(map);

      Get.printInfo(info: '✅ Parsed Response: $map');
      return map;
    } on SocketException {
      Get.printInfo(info: '❌ Network Error: No Internet Connection');
      SnackBars.errorSnackBar(content: 'No Internet Connection');
      throw FetchDataException('No Internet connection');
    } catch (e) {
      Get.printInfo(info: '❌ Unexpected Error: $e');
      //SnackBars.errorSnackBar(content: 'Unexpected error occurred');
      throw FetchDataException('Unexpected error: $e');
    }
  }

  Future<dynamic> deleteObject({required String url, required Object body}) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${myPref.getToken()}',
      };

      Get.printInfo(info: '🌐 API POST Request:');
      Get.printInfo(info: '   URL: ${baseUrl + url}');
      Get.printInfo(info: '   Headers: $headers');
      Get.printInfo(info: '   Body: $body');

      final request = http.Request('DELETE', Uri.parse(baseUrl + url));
      request.body = json.encode(body);
      request.headers.addAll(headers);

      final http.StreamedResponse response = await request.send();

      Get.printInfo(info: '📡 API Response:');
      Get.printInfo(info: '   Status: ${response.statusCode}');
      Get.printInfo(info: '   Headers: ${response.headers}');

      final map = await _returnResponse(response);

      // Check for invalid/expired token in response body
      _checkTokenValidity(map);

      Get.printInfo(info: '✅ Parsed Response: $map');
      return map;
    } on SocketException {
      Get.printInfo(info: '❌ Network Error: No Internet Connection');
      SnackBars.errorSnackBar(content: 'No Internet Connection');
      throw FetchDataException('No Internet connection');
    } catch (e) {
      Get.printInfo(info: '❌ Unexpected Error: $e');
      //SnackBars.errorSnackBar(content: 'Unexpected error occurred');
      throw FetchDataException('Unexpected error: $e');
    }
  }

  /// Handle HTTP response and return parsed data
  Future<dynamic> _returnResponse(http.StreamedResponse response) async {
    final responseString = await response.stream.bytesToString();

    switch (response.statusCode) {
      case 200:
        final responseJson = json.decode(responseString);
        return responseJson;

      case 201:
        final responseJson = json.decode(responseString);
        return responseJson;
      case 400:
        showErrorSheet(ErrorModel.fromJson(json.decode(responseString)).message ?? 'Bad Request');
        throw BadRequestException(
          ErrorModel.fromJson(json.decode(responseString)).message ?? 'Bad Request',
        );
      case 401:
        final responseJson = json.decode(responseString);
        final message = responseJson['message']?.toString();

        // Check for token expiry on 401 status
        if (message == "Invalid or expired token" ||
            (message?.toLowerCase().contains("invalid") == true &&
                message?.toLowerCase().contains("expired") == true &&
                message?.toLowerCase().contains("token") == true)) {
          Get.printInfo(info: '🔑 401 Unauthorized - Token Expired: $message');
          _handleTokenExpiry();
          return responseJson; // Return response but don't throw exception
        }

        // For non-token-expiry 401 errors (like login failures), return the response
        // so the caller can handle it (e.g., show specific error messages)
        Get.printInfo(info: '⚠️ 401 Unauthorized - Authentication Error: $message');
        showErrorSheet(message ?? 'Unauthorized');
        return responseJson; // Return response instead of throwing

      case 403:
        showErrorSheet(ErrorModel.fromJson(json.decode(responseString)).message ?? 'Forbidden');
        throw UnauthorisedException(
          ErrorModel.fromJson(json.decode(responseString)).message ?? 'Forbidden',
        );

      case 404:
        showErrorSheet(ErrorModel.fromJson(json.decode(responseString)).message ?? 'Not Found');
        throw UnauthorisedException(
          ErrorModel.fromJson(json.decode(responseString)).message ?? 'Not Found',
        );

      case 409:
        showErrorSheet(
          ErrorModel.fromJson(json.decode(responseString)).message ?? 'Conflict Error',
        );
        throw BadRequestException(
          ErrorModel.fromJson(json.decode(responseString)).message ?? 'Conflict Error',
        );
      case 502:
        showErrorSheet('Server is down. Please try again later.');
        throw BadRequestException('Server is down. Please try again later.');

      case 500:
      default:
        showErrorSheet(
          ErrorModel.fromJson(json.decode(responseString)).message ?? 'Conflict Error',
        );

        throw FetchDataException(
          'Error occurred while communicating with Server. Status Code: ${response.statusCode}',
        );
    }
  }
}
