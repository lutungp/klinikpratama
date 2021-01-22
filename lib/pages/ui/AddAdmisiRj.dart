import 'package:flutter/material.dart';
import 'package:klinikpratama/bloc/navigation_bloc/navigation_bloc.dart';

class AddAdmisiRjPage extends StatefulWidget with NavigationStates {
  final String norm;
  final Function onMenuTap;
  const AddAdmisiRjPage({Key key, this.norm, this.onMenuTap}) : super(key: key);
  AddAdmisiRjState createState() => AddAdmisiRjState();
}

class AddAdmisiRjState extends State<AddAdmisiRjPage> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(key: formKey, child: Column(children: []));
  }
}
