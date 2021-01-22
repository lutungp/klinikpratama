class MDokter {
  String pegawai_id, pegawai_name;

  MDokter(this.pegawai_id, this.pegawai_name);

  MDokter.fromJson(Map<String, dynamic> json) {
    pegawai_id = json['pegawai_id'];
    pegawai_name = json['pegawai_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pegawai_id'] = this.pegawai_id;
    data['pegawai_name'] = this.pegawai_name;
    return data;
  }
}
