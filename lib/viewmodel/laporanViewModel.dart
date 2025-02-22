import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skripsi_project/config/api.dart';
import 'package:skripsi_project/helper/database_lokal.dart';
import 'package:skripsi_project/model/Laporan_model.dart';
import 'package:http/http.dart' as http;

class LaporanViewModel {
  Future<List<Laporan>> fetchLaporan(String token) async {
    try {
      final response = await http.get(
        Uri.parse(Api.allLaporan),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['laporan'].isNotEmpty) {
          return jsonData['laporan']
              .map<Laporan>((json) => Laporan.fromJson(json))
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

  static final laporanProvider =
      FutureProvider.autoDispose<List<Laporan>>((ref) async {
    final token = await retrieveToken();
    if (token != null) {
      final laporanViewModel = LaporanViewModel();
      return laporanViewModel.fetchLaporan(token);
    } else {
      throw Exception('User is not logged in');
    }
  });
}
