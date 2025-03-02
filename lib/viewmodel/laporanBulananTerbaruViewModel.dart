import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skripsi_project/config/api.dart';
import 'package:http/http.dart' as http;
import 'package:skripsi_project/model/bulananTerbaru_model.dart';

class LaporanBulananTerbaruViewModel {
  Future<laporanBulananTerbaru> fetchLaporan() async {
    try {
      final response = await http.get(Uri.parse(Api.laporanBulananNew));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print("bulanan :${jsonData}");
        if (jsonData.containsKey('laporanBulananTerbaru')) {
          return laporanBulananTerbaru
              .fromJson(jsonData['laporanBulananTerbaru']);
        } else {
          throw Exception('No laporan data found.');
        }
      } else {
        throw Exception(
          'Failed to load laporan data. Status code: ${response.statusCode}. Error message: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching laporan data: ${e.toString()}');
    }
  }

  // Provider tanpa token
  static final laporanProvider =
      FutureProvider.autoDispose<laporanBulananTerbaru>((ref) async {
    final laporanHarianTerbaruViewModel = LaporanBulananTerbaruViewModel();
    return laporanHarianTerbaruViewModel.fetchLaporan();
  });
}
