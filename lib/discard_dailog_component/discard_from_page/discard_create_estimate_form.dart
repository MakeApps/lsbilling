import 'package:flutter/material.dart';
import 'package:local_shout_billing/config/colors.dart';

class DiscardCreateEstimateDailog extends StatelessWidget {
  const DiscardCreateEstimateDailog({super.key});

  Future<bool?> showCreateEstimateDiscardDailog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: whiteColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(3),
                ),
              ),
              title: const Text(
                'Are you sure you want to discard the Estimate?',
                style: TextStyle(
                    color: blackColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
              actions: <Widget>[
                ElevatedButton(
                  style: const ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(primaryColor),
                    foregroundColor: WidgetStatePropertyAll(blackColor),
                  ),
                  child: const Text(
                    'Discard',
                    style: TextStyle(
                        color: blackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    side: WidgetStatePropertyAll(
                      BorderSide(
                        color: primaryColor,
                      ),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(whiteColor),
                    foregroundColor: WidgetStatePropertyAll(blackColor),
                  ),
                  child: const Text(
                    'Keep Editing',
                    style: TextStyle(
                        color: blackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<bool> show(BuildContext context) async {
    return await showCreateEstimateDiscardDailog(context) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
