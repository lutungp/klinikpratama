import 'package:flutter/material.dart';
import 'package:klinikpratama/services/authService.dart';
import 'package:klinikpratama/loader/dialogLoader.dart';
import 'package:klinikpratama/constants.dart';
import './MainPage.dart';

import 'dart:async';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  bool _isInAsyncCall = false;
  var authInfo;

  final userloginCtrl = TextEditingController(text: "");
  final passwordloginCtrl = TextEditingController(text: "");
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _buildUserName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextField(
                controller: userloginCtrl,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(Icons.person, color: Colors.white),
                    hintText: 'Enter your username',
                    hintStyle: kHintTextStyle)))
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: passwordloginCtrl,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => _login(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color(0xFF73AEF5),
                Color(0xFF61A4F1),
                Color(0xFF478DE0),
                Color(0xFF398AE5)
              ],
                  stops: [
                0.1,
                0.4,
                0.7,
                0.9
              ])),
        ),
        Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Klinik Pratama Sehat',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 30.0),
                _buildUserName(),
                SizedBox(height: 30.0),
                _buildPasswordTF(),
                _buildLoginBtn()
              ],
            ),
          ),
        )
      ],
    ));
  }

  Future<dynamic> _login() async {
    final JsonDecoder _decoder = new JsonDecoder();
    Dialogs.showLoadingDialog(context, _scaffoldKey);
    try {
      authInfo = AuthService();
      final res =
          await authInfo.login(userloginCtrl.text, passwordloginCtrl.text);
      var datauser = _decoder.convert(res.body);

      Navigator.of(_scaffoldKey.currentContext, rootNavigator: true).pop();

      if (res.statusCode != 200) {
        setState(() {
          _isInAsyncCall = false;
        });
        setState(() {
          _isInAsyncCall = false;
          showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                    content: new Text(datauser["message"]),
                  ));
        });
      } else {
        AuthService.setToken(datauser['token'], datauser['refreshToken']);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => MainPage()));

        return datauser;
      }
    } catch (e) {
      Navigator.of(_scaffoldKey.currentContext, rootNavigator: true).pop();
      _isInAsyncCall = false;
      print(e);
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                content: new Text("Tidak terhubung dengan server"),
              ));
      setState(() {
        _isInAsyncCall = false;
      });
      return null;
    }
  }
}
