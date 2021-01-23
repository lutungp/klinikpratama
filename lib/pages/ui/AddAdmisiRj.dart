import 'package:flutter/material.dart';
import 'package:klinikpratama/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:klinikpratama/models/MAdmisiRJ.dart';
import 'package:klinikpratama/pages/ui/DataPasien.dart';
import '../../mixins/daftarRjvalidation.dart';
import 'package:klinikpratama/services/ApiService.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'DataDokter.dart';
import 'MyTextFieldDatePicker.dart';

class AddAdmisiRjPage extends StatefulWidget
    with NavigationStates, DaftarValidation {
  final String norm;
  final Function onMenuTap;
  const AddAdmisiRjPage({Key key, this.norm, this.onMenuTap}) : super(key: key);
  AddAdmisiRjState createState() => AddAdmisiRjState();
}

class AddAdmisiRjState extends State<AddAdmisiRjPage> {
  ApiService _apiService = ApiService();

  final formKey = GlobalKey<FormState>();
  MAdmisiRJ model = MAdmisiRJ();

  final TextEditingController _pasienController = TextEditingController();
  final TextEditingController _dokterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child:
            Column(children: [normField(), dokterField(), tglDaftarField()]));
  }

  Widget normField() {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          controller: this._pasienController,
          decoration: InputDecoration(labelText: 'Pilih Pasien')),
      suggestionsCallback: (pattern) {
        return DataPasienService.getSuggestions(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
            title: Text(suggestion["name"]),
            subtitle: Text(suggestion["daftar_no"]));
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: (suggestion) {
        model.id = suggestion["id"];
        this._pasienController.text = suggestion["name"];
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Pilih dokter terlebih dahulu';
        }
      },
    );
  }

  Widget dokterField() {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          controller: this._dokterController,
          decoration: InputDecoration(labelText: 'Pilih Dokter')),
      suggestionsCallback: (pattern) {
        return DataDokterService.getSuggestions(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(title: Text(suggestion["name"]));
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: (suggestion) {
        model.dokter = suggestion["id"];
        this._dokterController.text = suggestion["name"];
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Pilih dokter terlebih dahulu';
        }
      },
    );
  }

  Widget tglDaftarField() {
    return MyTextFieldDatePicker(
      labelText: "Tgl. Daftar",
      lastDate: DateTime.now().add(Duration(days: 366)),
      firstDate: DateTime(1900, 1),
      initialDate: DateTime.now().add(Duration(days: 1)),
      onDateChanged: (selectedDate) {
        setState(() {
          model.tgldaftar = selectedDate;
        });
      },
    );
  }
}
