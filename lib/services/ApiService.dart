import 'dart:async';
import 'package:dio/dio.dart';
import 'package:klinikpratama/services/authService.dart';
import 'dart:convert';

class ApiService {
  var _dio = Dio();
  String baseUrlNew = "http://192.168.8.101:8000/";
  Future<Dio> api() async {
    // EasyLoading.showProgress(2, status: 'loading');
    var gettoken = await AuthService().getMyToken();
    String token = gettoken["token"];
    _dio.interceptors.clear();
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      // Do something before request is sent
      if (token != null) {
        options.headers["Authorization"] = "Bearer " + token;
      }
      return options;
    }, onResponse: (Response response) {
      // Do something with response data
      return response; // continue
    }, onError: (DioError error) async {
      // Do something with response error //
      print(error.response);
    }));
    _dio.options.baseUrl = baseUrlNew;
    return _dio;
  }
}
