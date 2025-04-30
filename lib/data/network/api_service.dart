import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:joes_jwellery_crm/core/utils/api_constant.dart';
import 'package:joes_jwellery_crm/data/exception/app_execption.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  late final Dio _dio;
  ApiService._internal(){
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstant.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log('🌐 FULL URL: ${options.uri}');   
          log('🔹 REQUEST [${options.method}] => PATH: ${options.path}');
          log('🔸 Headers: ${options.headers}');
          log('🔸 Query: ${options.queryParameters}');
          log('🔸 Body: ${options.data}');
          return handler.next(options); 
        },
        onResponse: (response, handler) {
          log('✅ RESPONSE [${response.statusCode}] => DATA: ${response.data}');
          return handler.next(response); 
        },
        onError: (DioException e, handler) {
          log('❌ ERROR [${e.response?.statusCode}] => MESSAGE: ${e.message}');
          log('❌ DATA: ${e.response?.data}');
          return handler.next(e); 
        },
      ),
    );
  }

  // final Dio _dio = Dio(
  //   BaseOptions(
  //     baseUrl: ApiConstant.baseUrl,
  //     connectTimeout: const Duration(seconds: 10),
  //     receiveTimeout: const Duration(seconds: 10),
  //     responseType: ResponseType.json,
  //   ),
  // );

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParams}) async {
    final query = _buildQueryParams(queryParams);
    try {
      final response = await _dio.get(path, queryParameters: query);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<dynamic> post(String path, {dynamic body, Map<String, dynamic>? queryParams}) async {
    final query = _buildQueryParams(queryParams);
    try {
      final response = await _dio.post(path, data: body, queryParameters: query);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Map<String, dynamic> _buildQueryParams(Map<String, dynamic>? queryParams) {
    return {
      ...Uri.splitQueryString(ApiConstant.baseParams),
      ...?queryParams,
    };
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 400:
        throw BadRequestException(response.data['error'] ?? ''); //Bad Request
      case 401:
      case 403:
        throw UnauthorisedException(response.data['error'] ?? ''); //Unauthorized
      case 500:
        throw InternalServerException(response.data['error'] ?? ''); //Server Error
      default:
        throw FetchDataException('Something went wrong');
    }
  }

  AppException _handleDioError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return FetchDataException('Connection timed out');
    } else if (error.type == DioExceptionType.badResponse) {
      final response = error.response;
      final message = response?.data['error'] ?? ''; //Unknown error
      switch (response?.statusCode) {
        case 400:
          return BadRequestException(message);
        case 401:
        case 403:
          return UnauthorisedException(message);
        case 500:
          return InternalServerException(message);
        default:
          return FetchDataException(message);
      }
    } else if (error.type == DioExceptionType.unknown) {
      return NoInternetException('No Internet Connection');
    } else {
      return FetchDataException('Unexpected error occurred');
    }
  }
}
