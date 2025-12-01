import 'package:local_shout_billing/components/skeleton/listing_skeleton.dart';
import 'package:local_shout_billing/modules/login/pages/login_page.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({super.key});

  Future<bool> _setInterval() async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Center(
        child: FutureBuilder(
          future: _setInterval(),
          builder: (context, intervalSnapshot) {
            if (!intervalSnapshot.hasData) {
              return const Skeleton();
            }
            return const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(bill, size: 90, color: greyColor),
                SizedBox(height: 10),
                Text(
                  "Oops!, No data found",
                  style: TextStyle(
                      fontSize: 19,
                      color: blackColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 80,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
