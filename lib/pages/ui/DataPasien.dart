import 'package:klinikpratama/services/ApiService.dart';
import 'package:intl/intl.dart';

ApiService _apiService = ApiService();
String tgl = DateFormat('yyyy-MM-dd').format(DateTime.now());
String jam = DateFormat('hh:mm').format(DateTime.now());

class DataPasienService {
  static Future<List> getSuggestions(String query) async {
    await Future.delayed(Duration(seconds: 1));

    var response = await _apiService.api().then((value) => value
        .post("master/pasien", data: {"search_pasien": query, "pageSize": 15}));

    var datapasien = response.data["datapasien"];
    return List.generate(datapasien.length, (index) {
      return {
        "id": datapasien[index]["pasien_id"],
        "norm": datapasien[index]["pasien_norm"],
        "name": datapasien[index]["pasien_nama"],
        "daftar_no": datapasien[index]["daftar_no"],
        "daftar_tanggal": datapasien[index]["daftar_tanggal"],
        "pegawai_nama": datapasien[index]["pegawai_nama"]
      };
    });
  }
}
