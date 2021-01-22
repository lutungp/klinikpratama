import 'dart:async';
import 'package:dio/dio.dart';
import 'package:klinikpratama/services/authService.dart';

class ApiService {
  var _dio = Dio();
  String baseUrlNew = "http://klinikapi.pratamasehat.com/api/";
  Future<Dio> api() async {
    // EasyLoading.showProgress(2, status: 'loading');
    var gettoken = await AuthService().getMyToken();
    String token = gettoken["refreshToken"];
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
      if (error.response.statusCode == 401) {
        _dio.interceptors.requestLock.lock();
        _dio.interceptors.responseLock.lock();
        RequestOptions options = error.response.request;
        var datarefresh = await AuthService().refreshToken();
        options.headers["Authorization"] = "Bearer " + datarefresh['token'];
        _dio.interceptors.requestLock.unlock();
        _dio.interceptors.responseLock.unlock();
        return _dio.request(options.path, options: options);
      } else if (error.response.statusCode == 429) {}
    }));
    _dio.options.baseUrl = baseUrlNew;
    return _dio;
  }
}
