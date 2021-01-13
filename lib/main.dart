import 'package:flutter/material.dart';
import 'package:klinikpratama/services/authService.dart';

import 'pages/Login.dart';
import 'pages/MainPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Klinik Pratama',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: AuthService.getToken(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return MainPage();
          } else {
            return LoginScreen();
          }
        },
      ),
      routes: {'/home': (_) => MainPage(), '/login': (_) => new LoginScreen()},
    );
  }
}
