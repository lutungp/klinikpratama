class MAdmisiRJ {
  String id, norm, name, dokter;
  DateTime tgldaftar;
  MAdmisiRJ({this.id, this.norm, this.name, this.tgldaftar, this.dokter});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['norm'] = this.norm;
    data['name'] = this.name;
    data['tgldaftar'] = this.tgldaftar;
    data['dokter'] = this.dokter;
    return data;
  }
}
