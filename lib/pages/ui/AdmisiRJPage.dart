import 'package:flutter/material.dart';
import 'package:klinikpratama/bloc/navigation_bloc/navigation_bloc.dart';

String name = '';
var notelpNode = FocusNode();

class AdmisiRJPage extends StatelessWidget with NavigationStates, Validation {
  final Function onMenuTap;

  const AdmisiRJPage({Key key, this.onMenuTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Container(
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
                      onTap: onMenuTap,
                    ),
                    Text("Pendaftaran",
                        style: TextStyle(fontSize: 24, color: Colors.blueGrey)),
                  ]),
              Form(
                  key: formKey, //MENGGUNAKAN GLOBAL KEY
                  child: Column(children: [nameField(), notelpField()]))
            ]));
  }

  Widget nameField() {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(labelText: 'Nama Lengkap'),
      validator: validateName,
      onSaved: (String value) {
        name = value;
      },
    );
  }

  Widget notelpField() {
    return TextFormField(
      focusNode: notelpNode,
      decoration: InputDecoration(labelText: 'No. Telepon'),
      validator: validateName,
      onSaved: (String value) {
        name = value;
      },
    );
  }
}

class Validation {
  String validateName(String value) {
    if (value.isEmpty || value.length < 3 || value.length > 100) {
      //JIKA VALUE KOSONG
      return 'Nama minimal 3 & maksimal 100 karakter'; //MAKA PESAN DITAMPILKAN
    }
    return null;
  }
}
