import 'package:flutter/material.dart';

class CustomWidth extends StatelessWidget {
  final double width;
  const CustomWidth({super.key, this.width = 10});
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
