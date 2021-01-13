import 'package:flutter/material.dart';
import 'package:klinikpratama/bloc/navigation_bloc/navigation_bloc.dart';

class MyDashboardPage extends StatelessWidget with NavigationStates {
  final Function onMenuTap;

  const MyDashboardPage({Key key, this.onMenuTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.yellowAccent,
        ),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      child: Icon(Icons.menu, color: Colors.black),
                      onTap: onMenuTap,
                    ),
                    Text("Dashboard",
                        style: TextStyle(fontSize: 24, color: Colors.black)),
                    Icon(Icons.settings, color: Colors.black),
                  ])
            ]));
  }
}
