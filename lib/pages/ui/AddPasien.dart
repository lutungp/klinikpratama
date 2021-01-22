import 'package:flutter/material.dart';
import 'package:klinikpratama/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:klinikpratama/services/ApiService.dart';
import 'MyTextFieldDatePicker.dart';
import '../../mixins/uservalidation.dart';
import 'package:klinikpratama/models/MPasienBaru.dart';
import 'package:klinikpratama/loader/dialogLoader.dart';
import 'package:cool_alert/cool_alert.dart';

String norm;
List<Map> _listGender = [
  {"value": "L", "text": 'Laki-laki'},
  {"value": "P", "text": 'Perempuan'}
];

class AddPasienPage extends StatefulWidget with NavigationStates, Validation {
  final Function onFlatButtonPressed;

  const AddPasienPage({Key key, this.onFlatButtonPressed}) : super(key: key);
  AddPasienState createState() => AddPasienState();
}

class AddPasienState extends State<AddPasienPage> {
  ApiService _apiService = ApiService();
  FocusNode telpNode, genderNode, agamaNode;

  List<dynamic> _listAgama = List();

  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  MPasienBaru model = MPasienBaru();

  void getAgama() async {
    try {
      var response =
          await _apiService.api().then((value) => value.get("master/agama"));
      setState(() {
        _listAgama = response.data;
      });
    } catch (e) {
      print("error");
    }
  }

  @override
  void initState() {
    super.initState();
    formKey.currentState?.reset();
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
    return Form(
        key: formKey,
        child: Column(children: [
          nameField(),
          notelpField(),
          genderField(),
          agamaField(),
          alamatField(),
          tgllahirField(),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10), child: usiaField()),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            _buildSubmitButton(),
            SizedBox(width: 20),
            _buildResetButton()
          ])
        ]));
  }

  Widget nameField() {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(labelText: 'Nama Lengkap'),
      validator: widget.validateName,
      onSaved: (String value) {
        model.name = value;
      },
      onEditingComplete: () => telpNode.nextFocus(),
    );
  }

  Widget notelpField() {
    return TextFormField(
      focusNode: telpNode,
      decoration: InputDecoration(labelText: 'No. Telepon'),
      keyboardType: TextInputType.number,
      validator: widget.notelpName,
      onSaved: (String value) {
        setState(() {
          model.notelp = value;
        });
      },
      onEditingComplete: () => genderNode.nextFocus(),
    );
  }

  Widget genderField() {
    return DropdownButtonFormField(
      focusNode: genderNode,
      isExpanded: true,
      hint: Text("Pilih Jenis Kelamin"),
      value: model.gender,
      items: _listGender.map((item) {
        return DropdownMenuItem(
          value: item["value"],
          child: Text(item["text"]),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          model.gender = value;
        });
      },
    );
  }

  Widget agamaField() {
    return DropdownButtonFormField(
      focusNode: agamaNode,
      isExpanded: true,
      hint: Text("Pilih Agama"),
      value: model.agama,
      items: _listAgama.map((item) {
        return DropdownMenuItem(
          value: item["agama_id"],
          child: Text(item["agama_nama"]),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          model.agama = value;
        });
      },
    );
  }

  Widget alamatField() {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(labelText: 'Alamat'),
      keyboardType: TextInputType.multiline,
      minLines: 1, //Normal textInputField will be displayed
      maxLines: 5, // when user presses enter it will adapt to it
      onSaved: (String value) {
        setState(() {
          model.alamat = value;
        });
      },
      onEditingComplete: () => telpNode.nextFocus(),
    );
  }

  Widget tgllahirField() {
    return MyTextFieldDatePicker(
      labelText: "Date",
      lastDate: DateTime.now().add(Duration(days: 366)),
      firstDate: DateTime(1900, 1),
      initialDate: DateTime.now().add(Duration(days: 1)),
      onDateChanged: (selectedDate) {
        setState(() {
          model.tgllahir = selectedDate;
        });
      },
    );
  }

  Widget usiaField() {
    int usia = calculateAge(model.tgllahir);
    return Text(
      'Usia : $usia',
      textAlign: TextAlign.right,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 24, color: Colors.blueGrey),
    );
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    if (birthDate == null) {
      return 0;
    }
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  Widget _buildSubmitButton() {
    return RaisedButton(
      onPressed: () {
        simpanPasienBaru();
      },
      color: Colors.blue,
      textColor: Colors.white,
      child: Text('Simpan'),
    );
  }

  Widget _buildResetButton() {
    return RaisedButton(
      onPressed: () {
        formKey.currentState?.reset();
      },
      color: Colors.redAccent,
      textColor: Colors.white,
      child: Text('Reset'),
    );
  }

  Future<dynamic> simpanPasienBaru() async {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      var databody = model.save();
      Dialogs.showLoadingDialog(context, _scaffoldKey);
      try {
        var response = await _apiService
            .api()
            .then((value) => value.post("master/createpasien", data: databody));

        Navigator.of(_scaffoldKey.currentContext, rootNavigator: true).pop();
        if (response.statusCode == 200) {
          setState(() {
            norm = response.data["norm"];
          });
          widget.onFlatButtonPressed(norm);
          formKey.currentState?.reset();
          CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: 'Pasien berhasil disimpan, dengan No. RM $norm',
          );
        } else {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: "Cek koneksi anda, atau hubungi administrator!",
          );
        }
      } catch (e) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "Cek koneksi anda, atau hubungi administrator!",
        );
      }
    }
  }
}
