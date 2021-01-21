import 'package:flutter/material.dart';
import 'package:klinikpratama/bloc/navigation_bloc/navigation_bloc.dart';

class AddAdmisiRjPage extends StatefulWidget with NavigationStates {
  final String norm;
  final Function onMenuTap;
  const AddAdmisiRjPage({Key key, this.norm, this.onMenuTap}) : super(key: key);
  AddAdmisiRjState createState() => AddAdmisiRjState();
}

class AddAdmisiRjState extends State<AddAdmisiRjPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
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
                              child: Icon(Icons.menu, color: Colors.blueGrey),
                              onTap: () {
                                widget.onMenuTap;
                              },
                            ),
                            Text("Pendaftaran",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.blueGrey)),
                          ])
                    ]))));
  }
}
