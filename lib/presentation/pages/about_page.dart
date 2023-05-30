import 'package:showtime_provider/common/constants.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  static const routeName = '/about';

  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: kPrussianBlue,
              child: const Center(
                child: Text(''),
                // child: Image.asset(
                //   'assets/circle-g.png',
                //   width: 128,
                // ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(32.0),
              color: kMikadoYellow,
              child: const Text(
                'ShowTime merupakan sebuah protoype aplikasi katalog film yang dikembangkan sebagai studi kasus untuk penelitian Analisis Performa State Management Provider dan GetX pada Aplikasi Flutter.',
                style: TextStyle(color: Colors.black87, fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
