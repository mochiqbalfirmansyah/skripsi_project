// Model: Laporan.dart
class laporanHarianTerbaru {
  final int id;
  final String tipe;
  final String title;
  final String deskripsi;
  final String dataHarian;
  final DateTime createdAt;
  final DateTime updatedAt;

  laporanHarianTerbaru({
    required this.id,
    required this.tipe,
    required this.title,
    required this.deskripsi,
    required this.dataHarian,
    required this.createdAt,
    required this.updatedAt,
  });

  factory laporanHarianTerbaru.fromJson(Map<String, dynamic> json) {
    return laporanHarianTerbaru(
      id: json['id_laporan'],
      tipe: json['tipe'],
      title: json['title'],
      deskripsi: json['deskripsi'],
      dataHarian: json['data_harian'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
