import 'package:flutter/material.dart';
import 'package:showtime_getx/common/constants.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.selectedPage,
    required this.onTap,
  });

  final int selectedPage;
  final Function(int) onTap;
  final _bottomNavBarItem = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movies'),
    BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'Series'),
    BottomNavigationBarItem(icon: Icon(Icons.save_alt), label: 'Watchlist'),
    BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: 'About'),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: kRichBlack,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      items: _bottomNavBarItem,
      currentIndex: selectedPage,
      onTap: onTap,
    );
  }
}
