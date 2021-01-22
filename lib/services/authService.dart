import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:klinikpratama/models/UserModel.dart';
import 'package:klinikpratama/LocalBindings.dart';
import 'dart:convert';
import 'ApiService.dart';

class AuthService {
  final baseUrl = 'http://klinikapi.pratamasehat.com/api';
  // ignore: non_constant_identifier_names
  static final SESSION = FlutterSession();

  UserModel _currentUser;

  UserModel get currentUser => _currentUser;

  set currentUser(UserModel value) => _currentUser;

  ApiService _apiProvider = ApiService();

  Future<dynamic> register(String email, String password) async {
    try {
      var res = await http.post('$baseUrl/auth/register', body: {
        'email': email,
        'password': password,
      });

      return res?.body;
    } finally {
      // done you can do something here
    }
  }

  Future<dynamic> login(String email, String password) async {
    var body = {
      'name': email,
      'password': password,
    };
    var res = await http.post('$baseUrl/user/login', body: body);
    if (res.statusCode == 200) {
      LocalStorage.sharedInstance
          .writeValue(key: 'UserLogin', value: json.encode(body));
    }

    return res;
  }

  Future refreshToken() async {
    String dataSession =
        await LocalStorage.sharedInstance.readValue('UserLogin');
    var body = json.decode(dataSession);
    try {
      var response = await http.post('$baseUrl/user/login', body: body);
      var res = response.body;
      return json.decode(res);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  static setUserLogin(String token, String refreshToken) async {
    _AuthData data = _AuthData(token, refreshToken);
    await SESSION.set('tokens', data);
  }

  static setToken(String token, String refreshToken) async {
    _AuthData data = _AuthData(token, refreshToken);
    await SESSION.set('tokens', data);
  }

  static Future<Map<String, dynamic>> getToken() async {
    return await SESSION.get('tokens');
  }

  static removeToken() async {
    await SESSION.prefs.clear();
  }

  getMyToken() async {
    return await SESSION.get('tokens');
  }
}

class _AuthData {
  String token, refreshToken, clientId;
  _AuthData(this.token, this.refreshToken, {this.clientId});

  // toJson
  // required by Session lib
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['token'] = token;
    data['refreshToken'] = refreshToken;
    data['clientId'] = clientId;
    return data;
  }
}
