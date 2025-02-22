import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skripsi_project/helper/cardNotification.dart';
import 'package:skripsi_project/helper/cardRiwayat.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => NotificationViewState();
}

class NotificationViewState extends State<NotificationView> {
  static const _pageSize = 5; // Jumlah item per halaman
  final PagingController<int, dynamic> _pagingController =
      PagingController(firstPageKey: 0);

  String selectedView = "Bulanan"; // Default tampilan adalah Bulanan

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final isLastPage = false;
      if (isLastPage) {
        _pagingController.appendLastPage([]);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(
            List.generate(_pageSize, (_) => {}), nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifikasi',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true, // Memastikan judul berada di tengah
        iconTheme: const IconThemeData(color: Colors.white), // Warna ikon back
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                const SizedBox(width: 8), // Jarak antar elemen
                Expanded(
                  flex: 3, // Mengatur proporsi ruang
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedView = "Bulanan";
                        _pagingController.refresh(); // Refresh data
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedView == "Bulanan"
                          ? Colors.blue
                          : Colors.grey[300],
                      foregroundColor: selectedView == "Bulanan"
                          ? Colors.white
                          : Colors.black,
                    ),
                    child: const Text("Bulanan"),
                  ),
                ),
                const SizedBox(width: 8), // Jarak antar elemen
                Expanded(
                  flex: 3, // Mengatur proporsi ruang
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedView = "Harian";
                        _pagingController.refresh(); // Refresh data
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedView == "Harian"
                          ? Colors.blue
                          : Colors.grey[300],
                      foregroundColor: selectedView == "Harian"
                          ? Colors.white
                          : Colors.black,
                    ),
                    child: const Text("Harian"),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PagedListView<int, dynamic>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<dynamic>(
                itemBuilder: (context, item, index) => NotificationCard(),
                firstPageErrorIndicatorBuilder: (context) => const Center(
                  child: Text("Error memuat data."),
                ),
                noItemsFoundIndicatorBuilder: (context) => const Center(
                  child: Text("Tidak ada data ditemukan."),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
