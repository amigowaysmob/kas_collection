import 'dart:convert';
import 'dart:io';


import 'package:dio/dio.dart';
import 'package:kascollection/utils/constants/sharedpreference_help.dart';
import 'package:kascollection/utils/utility/network/expection.dart';

import 'package:path/path.dart'; // for basename()
class ApiService {
  final Dio dio;
  SharedPreferenceHelper? sharedPreferenceHelper;

  ApiService(this.dio, this.sharedPreferenceHelper) {
    // Add an interceptor to log request details
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('Request Headers: ${options.headers}');
        print('Request Body: ${options.data}');
        return handler.next(options); // Continue with the request
      },
      onResponse: (response, handler) {
        // Handle response
        return handler.next(response); // Continue with the response
      },
      onError: (DioError e, handler) {
        // Handle error
        return handler.next(e); // Continue with the error
      },
    ));
  }

  Future<Map<String, dynamic>> _getHeaders() async {
    final token = await sharedPreferenceHelper?.getToken;
    print('token-print-----${token}');
    return {
      'X-CSRF-TOKEN': 'Bearer $token' ?? '',
      'Accept': 'application/json',
    };
  }

  Future<Response> get(String endpoint, Map<String, dynamic> queryParams,) async {
    try {
      final response = await dio.get(endpoint, queryParameters: queryParams);
      return response;
    } on DioError catch (e) {
      throw DataException.fromDioError(e);
    }
  }

  Future<Response> post(String endpoint, dynamic body, {Map<String, dynamic>? headers, bool isFormData = false}) async {
    try {
      headers ??= await _getHeaders();  // Use the headers provided or fallback to _getHeaders

      final options = Options(
        headers: headers,
      );

      Response response;
      if (isFormData) {
        // Post with FormData
        response = await dio.post(
          endpoint,
          data: body as FormData, // Expecting FormData here
          options: options,
        );
      } else {
        // Post with JSON
        response = await dio.post(
          endpoint,
          data: jsonEncode(body), // Ensure the body is encoded to JSON
          options: options,
        );
      }
      
      return response;
    } on DioError catch (e) {
      throw DataException.fromDioError(e);
    }
  }

  FormData mapToFormData(Map<String, dynamic> data) {
    final formData = FormData();
    data.forEach((key, value) {
      if (value is File) {
        // If value is a file, add it to FormData
        formData.files.add(MapEntry(
          key,
          MultipartFile.fromFileSync(value.path, filename: basename(value.path)),
        ));
      } else {
        // Add other fields as text
        formData.fields.add(MapEntry(key, value.toString()));
      }
    });
    return formData;
  }
}
