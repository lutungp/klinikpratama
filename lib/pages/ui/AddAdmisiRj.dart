import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:klinikpratama/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:klinikpratama/models/MAdmisiRJ.dart';
import '../../mixins/daftarRjvalidation.dart';
import 'package:klinikpratama/services/ApiService.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'DataDokter.dart';

class AddAdmisiRjPage extends StatefulWidget
    with NavigationStates, DaftarValidation {
  final String norm;
  final Function onMenuTap;
  const AddAdmisiRjPage({Key key, this.norm, this.onMenuTap}) : super(key: key);
  AddAdmisiRjState createState() => AddAdmisiRjState();
}

class AddAdmisiRjState extends State<AddAdmisiRjPage> {
  ApiService _apiService = ApiService();
  FocusNode dokterNode;
  List<dynamic> _listDokter = List();

  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  MAdmisiRJ model = MAdmisiRJ();

  final TextEditingController _typeAheadController = TextEditingController();
  String _selectedDokter;

  void getDokter() async {
    String tgl = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String jam = DateFormat('hh:mm').format(DateTime.now());
    try {
      var response = await _apiService
          .api()
          .then((value) => value.post("master/dokter", data: {
                "unit_id": 73,
                "tgl": tgl,
                "jam": jam,
                "daftar_jenis": "INST. RAWAT JALAN",
                "search_pegawai": "",
                "pageSize": 15
              }));
      setState(() {
        _listDokter = response.data;
      });
    } catch (e) {
      print("error");
    }
  }

  @override
  void initState() {
    super.initState();
    formKey.currentState?.reset();
    dokterNode = FocusNode();

    getDokter();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(children: [normField(), namaField(), dokterField()]));
  }

  Widget normField() {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(labelText: 'No. RM'),
      validator: widget.validateNorm,
      onSaved: (String value) {
        model.norm = value;
      },
      // onEditingComplete: () => telpNode.nextFocus(),
    );
  }

  Widget namaField() {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(labelText: 'Nama Pasien'),
    );
  }

  Widget dokterField() {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          controller: this._typeAheadController,
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
      onSuggestionSelected: (suggestion) {},
      validator: (value) {
        if (value.isEmpty) {
          return 'Pilih dokter terlebih dahulu';
        }
      },
    );
  }
}
