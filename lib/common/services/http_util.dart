import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:e_learning_app/common/utils/app_constants.dart';
import 'package:e_learning_app/global.dart';
import 'package:flutter/foundation.dart';

class HttpUtil {
  late Dio dio;

  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() {
    return _instance;
  }

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
        baseUrl: AppConstants.SERVER_API_URL,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {},
        contentType: "application/json: charset=utf-8",
        responseType: ResponseType.json);

    dio = Dio(options);

    // dio.httpClientAdapter = IOHttpClientAdapter(
    //     createHttpClient: (){
    //       HttpClient client = HttpClient();
    //       client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    //       return client;
    //     }
    // );

    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        if (kDebugMode) {
          print('request data: ${options.data}');
        }
      return handler.next(options);
    }, onResponse: (response, handler) {
        if (kDebugMode) {
          print('response data: ${response.data}');
        }
      return handler.next(response);
    }, onError: (DioException error, handler) {
        if (kDebugMode) {
          print('error data: $error');
        }
      ErrorEntity errorInfo = createErrorEntity(error);
      onError(errorInfo);
    }));
  }

  // headers can be nullable
  Map<String, dynamic>? getAuthorizationHeader() {
    var headers = <String, dynamic>{};
    var accessToken = Global.storageService.getUserToken();

    if (accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    return headers;
  }

  Future post(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};

    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }

    var response = await dio.post(path,
        data: data, queryParameters: queryParameters, options: requestOptions);

    return response.data;
  }
}

class ErrorEntity implements Exception {
  int code = -1;
  String message = "";

  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message == "") {
      return "Exception";
    }
    return "Exception code $code, $message";
  }
}

ErrorEntity createErrorEntity(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return ErrorEntity(code: -1, message: "Connection timeout");

    case DioExceptionType.sendTimeout:
      return ErrorEntity(code: -1, message: "Send timeout");

    case DioExceptionType.receiveTimeout:
      return ErrorEntity(code: -1, message: "Receive timeout");

    case DioExceptionType.badCertificate:
      return ErrorEntity(code: -1, message: "Bass SSL timeout");

    case DioExceptionType.badResponse:
      switch (error.response!.statusCode) {
        case 400:
          return ErrorEntity(code: 400, message: "Request syntax error");
        case 401:
          return ErrorEntity(code: 401, message: "Permission deny");
        case 500:
          return ErrorEntity(code: 500, message: "Server internal error");
      }
      return ErrorEntity(
          code: error.response!.statusCode!, message: "Server bad response");

    case DioExceptionType.cancel:
      return ErrorEntity(code: -1, message: "Server canceled request");

    case DioExceptionType.connectionError:
      return ErrorEntity(code: -1, message: "Connection error");

    case DioExceptionType.unknown:
      return ErrorEntity(code: -1, message: "Unknown error");
  }
}

void onError(ErrorEntity errorInfo) {
  print(
      'error.code -> ${errorInfo.code}, error.message -> ${errorInfo.message}');
  switch (errorInfo.code) {
    case 400:
      print('Server syntax error');
      break;
    case 401:
      print('Server permission deny');
      break;
    case 500:
      print('Internal server error');
      break;
    default:
      print('Unknown error');
      break;
  }
}
