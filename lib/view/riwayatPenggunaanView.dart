import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RiwayatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Home Screen',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/riwayat'); // Pindah ke halaman Riwayat
              },
              child: Text('Go to Riwayat'),
            ),
          ],
        ),
      ),
    );
  }
}
