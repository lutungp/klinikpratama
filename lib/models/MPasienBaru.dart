class MPasienBaru {
  String name, notelp, gender, agama, alamat;
  DateTime tgllahir;

  MPasienBaru(
      {this.name,
      this.notelp,
      this.gender,
      this.agama,
      this.alamat,
      this.tgllahir});

  save() {
    print('saving user using a web service');
  }
}
