import 'package:showtime_provider/common/constants.dart';
import 'package:flutter/material.dart';

class SubHeading extends StatelessWidget {
  final String title;
  final Function() onTap;

  const SubHeading({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        top: 8.0,
        bottom: 8.0,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: kHeading6,
            ),
            Row(
              children: [
                Text(
                  'See More',
                  style: kSubtitle,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
