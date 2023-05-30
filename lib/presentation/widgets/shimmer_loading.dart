import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:showtime_provider/common/constants.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    Key? key,
    this.height,
    this.width,
    this.radius = 24.0,
    this.baseColor,
    this.highlightColor = Colors.white70,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double radius;
  final Color? baseColor;
  final Color highlightColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kGrey,
      highlightColor: highlightColor,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}
