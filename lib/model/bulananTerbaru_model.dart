// Model: Laporan.dart
class laporanBulananTerbaru {
  final int id;
  final String tipe;
  final String title;
  final String deskripsi;
  final String dataHarian;
  final DateTime createdAt;
  final DateTime updatedAt;

  laporanBulananTerbaru({
    required this.id,
    required this.tipe,
    required this.title,
    required this.deskripsi,
    required this.dataHarian,
    required this.createdAt,
    required this.updatedAt,
  });

  factory laporanBulananTerbaru.fromJson(Map<String, dynamic> json) {
    return laporanBulananTerbaru(
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
