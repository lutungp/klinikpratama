import 'package:intl/intl.dart';

class MAdmisiRJ {
  String norm, name, tgldaftar, dokter;
  MAdmisiRJ({this.norm, this.name, this.tgldaftar, this.dokter});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['norm'] = this.norm;
    data['name'] = this.name;
    data['tgldaftar'] = this.tgldaftar;
    data['dokter'] = this.dokter;
    return data;
  }
}
