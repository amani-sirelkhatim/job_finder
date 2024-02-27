import 'package:flutter/material.dart';
import 'package:job_finder/core/utils/style.dart';

class label extends StatelessWidget {
  const label(
      {super.key, required this.name, required this.color, required this.size});
  final String name;
  final Color color;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: getTitleStyle(color: color, fontSize: size),
    );
  }
}
