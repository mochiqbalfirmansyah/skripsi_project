import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:skripsi_project/view/notificationView.dart';
import 'package:skripsi_project/viewmodel/laporanBulananTerbaruViewModel.dart';
import 'package:skripsi_project/viewmodel/laporanBulananViewModel.dart';
import 'package:skripsi_project/viewmodel/laporanHarianTerbaruViewModel.dart';
import 'package:skripsi_project/viewmodel/laporanViewModel.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final laporanDayNew =
        ref.watch(LaporanHarianTerbaruViewModel.laporanProvider);
    final laporanMonthNew =
        ref.watch(LaporanBulananTerbaruViewModel.laporanProvider);
    final laporanMonth = ref.watch(LaporanBulananViewModel.laporanProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Pengelolaan Air PDAM',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationView()),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Statistik
                Row(
                  children: const [
                    Icon(Icons.bar_chart, color: Colors.blue, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'Statistik Bulanan',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Grafik BarChart
                SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 20,
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(fontSize: 12),
                              );
                            },
                          ),
                        ),
                        leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                      ),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      barGroups: List.generate(
                        12,
                        (index) => BarChartGroupData(
                          x: index + 1,
                          barRods: [
                            BarChartRodData(
                              toY: (index % 3 + 1) * 5.0,
                              color: Colors.blue.shade200,
                              width: 16,
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(4)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Ringkasan Penggunaan
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.info, color: Colors.blue, size: 24),
                        SizedBox(width: 8),
                        Text(
                          'Ringkasan Penggunaan',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Data Penggunaan
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Hari Ini'),
                              const SizedBox(height: 4),
                              laporanDayNew.when(
                                data: (laporan) => Text(
                                  "${laporan.dataHarian} m",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                loading: () =>
                                    const CircularProgressIndicator(),
                                error: (err, stack) => Text('Error: $err'),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Bulan ini'),
                              const SizedBox(height: 4),
                              laporanMonthNew.when(
                                data: (laporanBulanan) => Text(
                                  "${laporanBulanan.dataHarian} m",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                loading: () =>
                                    const CircularProgressIndicator(),
                                error: (err, stack) => Text('Error: $err'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Riwayat Terbaru
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.history, color: Colors.blue, size: 24),
                        SizedBox(width: 8),
                        Text(
                          'Riwayat Terbaru',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: laporanDayNew.when(
                        data: (laporan) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("31 Feb 25",
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(
                                'Penggunaan Hari ini : ${laporan.dataHarian} m',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          );
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (err, stack) => Center(
                          child: Text(
                            'Terjadi kesalahan: $err',
                            style: const TextStyle(
                                color: Colors.red, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
