import 'package:flutter/material.dart';

class TabBarItem extends StatelessWidget {
  const TabBarItem({super.key, required this.tabMovie});
  final bool tabMovie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            tabMovie ? Icons.movie : Icons.tv,
          ),
          const SizedBox(
            width: 12.0,
          ),
          Text(
            tabMovie ? 'Movies' : 'Tv Series',
          ),
        ],
      ),
    );
  }
}
