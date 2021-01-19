import 'package:intl/intl.dart';

class MPasienBaru {
  String name, notelp, gender, agama, alamat;
  DateTime tgllahir = DateTime.now();

  MPasienBaru(
      {this.name,
      this.notelp,
      this.gender,
      this.agama,
      this.alamat,
      this.tgllahir});

  save() {
    String tgllahir = this.tgllahir != null
        ? DateFormat('yyyy-MM-dd').format(this.tgllahir)
        : DateFormat('yyyy-MM-dd').format(DateTime.now());
    Map<String, dynamic> body = {
      "name": name,
      "notelp": notelp,
      "gender": gender,
      "agama": agama,
      "alamat": alamat,
      "tgllahir": tgllahir,
    };

    return body;
  }
}
