import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skripsi_project/config/api.dart';
import 'package:http/http.dart' as http;
import 'package:skripsi_project/model/harianTerbaru_model.dart';

class LaporanHarianTerbaruViewModel {
  Future<laporanHarianTerbaru> fetchLaporan() async {
    try {
      final response = await http.get(Uri.parse(Api.laporanHarianNew));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData.containsKey('laporanHarianTerbaru')) {
          return laporanHarianTerbaru
              .fromJson(jsonData['laporanHarianTerbaru']);
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
      FutureProvider.autoDispose<laporanHarianTerbaru>((ref) async {
    final laporanHarianTerbaruViewModel = LaporanHarianTerbaruViewModel();
    return laporanHarianTerbaruViewModel.fetchLaporan();
  });
}
