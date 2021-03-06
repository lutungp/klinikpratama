import 'package:klinikpratama/services/ApiService.dart';
import 'package:intl/intl.dart';

ApiService _apiService = ApiService();
DateTime now = DateTime.now();
String tgl = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
String jam = DateFormat('HH:mm:ss').format(now);

class DataDokterService {
  static Future<List> getSuggestions(String query) async {
    await Future.delayed(Duration(seconds: 1));

    var response = await _apiService
        .api()
        .then((value) => value.post("master/dokter", data: {
              "unit_id": 73,
              "tgl": tgl,
              "jam": jam,
              "daftar_jenis": "INST. RAWAT JALAN",
              "search_pegawai": query,
              "pageSize": 15
            }));

    return List.generate(response.data.length, (index) {
      return {
        "name": response.data[index]["pegawai_nama"],
        "id": response.data[index]["pegawai_id"]
      };
    });
  }
}
