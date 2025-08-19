import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularGraph extends StatelessWidget {
  final double percent;
  const CircularGraph({
    super.key,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 60,
      animation: true,
      lineWidth: 6,
      percent: percent,
      backgroundColor: Colors.blueGrey,
      animateFromLastPercent: true,
      progressColor: Colors.white,
      center: Text(
        "${(percent * 100).toStringAsFixed(0)}%",
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
