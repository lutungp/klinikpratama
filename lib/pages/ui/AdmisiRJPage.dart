import 'package:flutter/material.dart';
import 'package:klinikpratama/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:klinikpratama/services/ApiService.dart';
import 'dart:convert';

String name, notelp, _valGender, _valAgama;
List<Map> _listGender = [
  {"value": "L", "text": 'Laki-laki'},
  {"value": "P", "text": 'Perempuan'}
];

class AdmisiRJPage extends StatefulWidget with NavigationStates, Validation {
  final Function onMenuTap;
  const AdmisiRJPage({Key key, this.onMenuTap}) : super(key: key);
  AdmisiRJSate createState() => AdmisiRJSate();
}

class AdmisiRJSate extends State<AdmisiRJPage> {
  ApiService _apiService = ApiService();
  FocusNode telpNode, genderNode, agamaNode;
  List<dynamic> _listAgama = List();

  void getAgama() async {
    try {
      var response =
          await _apiService.api().then((value) => value.get("master/agama"));
      print(response);
    } catch (e) {
      print("error");
    }
    // var token = ApiService.httpRequest;
    // final respose = await http.get(_baseUrl + "master/agama");
    // var listData = json.decode(respose.body);
    // setState(() {
    //   _listAgama = listData;
    // });
    // print("data : $listData");
  }

  @override
  void initState() {
    super.initState();

    telpNode = FocusNode();
    genderNode = FocusNode();

    getAgama();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    telpNode.dispose();
    genderNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
                              onTap: widget.onMenuTap,
                            ),
                            Text("Pendaftaran",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.blueGrey)),
                          ]),
                      Form(
                          key: formKey, //MENGGUNAKAN GLOBAL KEY
                          child: Column(children: [
                            nameField(),
                            notelpField(),
                            genderField(),
                            agamaField()
                          ]))
                    ]))));
  }

  Widget nameField() {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(labelText: 'Nama Lengkap'),
      validator: widget.validateName,
      onSaved: (String value) {
        name = value;
      },
      onEditingComplete: () => telpNode.nextFocus(),
    );
  }

  Widget notelpField() {
    return TextFormField(
      focusNode: telpNode,
      decoration: InputDecoration(labelText: 'No. Telepon'),
      validator: widget.validateName,
      onSaved: (String value) {
        notelp = value;
      },
      onEditingComplete: () => genderNode.nextFocus(),
    );
  }

  Widget genderField() {
    return DropdownButtonFormField(
      focusNode: genderNode,
      isExpanded: true,
      hint: Text("Pilih Jenis Kelamin"),
      value: _valGender,
      items: _listGender.map((item) {
        return DropdownMenuItem(
          value: item["value"],
          child: Text(item["text"]),
        );
      }).toList(),
      onChanged: (value) {
        _valGender = value;
      },
    );
  }

  Widget agamaField() {
    return DropdownButtonFormField(
      focusNode: agamaNode,
      isExpanded: true,
      hint: Text("Pilih Agama"),
      value: _valGender,
      items: _listGender.map((item) {
        return DropdownMenuItem(
          value: item["value"],
          child: Text(item["text"]),
        );
      }).toList(),
      onChanged: (value) {
        _valAgama = value;
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
