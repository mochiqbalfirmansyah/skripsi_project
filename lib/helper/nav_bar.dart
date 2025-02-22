import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavbar extends StatelessWidget {
  final int selectedIndex;

  const CustomNavbar({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/home');
            break;
          case 1:
            context.go('/riwayat');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.access_time),
          label: 'Riwayat',
        ),
      ],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black54,
      backgroundColor: Colors.blue,
    );
  }
}
