import 'package:flutter/material.dart';
import 'package:local_shout_billing/config/colors.dart';

class FormFieldTitle extends StatelessWidget {
  final String title;
  const FormFieldTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 17,
        right: 10,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: const TextStyle(
              color: blackColor, fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
