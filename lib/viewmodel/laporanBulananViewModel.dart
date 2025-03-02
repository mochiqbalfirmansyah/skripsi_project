import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skripsi_project/config/api.dart';
import 'package:http/http.dart' as http;
import 'package:skripsi_project/model/bulananTerbaru_model.dart';
import 'package:skripsi_project/model/bulanan_model.dart';

class LaporanBulananViewModel {
  Future<List<laporanBulanan>> fetchLaporan() async {
    try {
      final response = await http.get(Uri.parse(Api.laporanBulananNew));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['laporanBulanan'].isNotEmpty) {
          return jsonData['laporanBulanan']
              .map<laporanBulanan>((json) => laporanBulanan.fromJson(json))
              .toList();
        } else {
          throw Exception('No laporan data found.');
        }
      } else {
        throw Exception(
            'Failed to load laporan data. Status code: ${response.statusCode}. Error message: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error fetching laporan data: ${e.toString()}');
    }
  }

  // Provider tanpa token
  static final laporanProvider =
      FutureProvider.autoDispose<List<laporanBulanan>>((ref) async {
    final laporanBulananViwModel = LaporanBulananViewModel();
    return laporanBulananViwModel.fetchLaporan();
  });
}
