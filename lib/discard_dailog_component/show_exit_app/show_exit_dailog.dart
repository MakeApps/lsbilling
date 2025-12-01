import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'dart:io';


class ExitConfirmationDialog extends StatelessWidget {
  const ExitConfirmationDialog({super.key});

  Future<void> _exitApp(BuildContext context) async {
    if (Platform.isAndroid) {
      try {
        await SystemNavigator.pop();
      } catch (e) {
        exit(0);
      }
    } else {
      exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(3),
        ),
      ),
      title: const Text(
        "Are you sure you want to exit the app?",
        style: TextStyle(
            color: blackColorDark, fontSize: 13, fontWeight: FontWeight.w500),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            await _exitApp(context);
          },
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(3),
                ),
              ),
              backgroundColor: primaryColor,
              foregroundColor: blackColor),
          child: const Text(
            "Yes, Exit",
            style: TextStyle(color: blackColor, fontSize: 12),
          ),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(3),
              ),
            ),
            backgroundColor: whiteColor,
            side: const BorderSide(color: primaryColor, width: 1),
          ),
          child: const Text(
            "No",
            style: TextStyle(color: blackColor, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

Future<void> showExitConfirmation(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const ExitConfirmationDialog();
    },
  );
}
