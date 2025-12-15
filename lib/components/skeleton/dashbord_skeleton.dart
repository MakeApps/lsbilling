import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../config/colors.dart';

class DashboardSkeleton extends StatelessWidget {
  const DashboardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: greyColor.withOpacity(0.3),
      highlightColor: lightColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top two cards
            Row(
              children: [
                Expanded(child: _topCard()),
                const SizedBox(width: 12),
                Expanded(child: _topCard()),
              ],
            ),
            const SizedBox(height: 16),

            /// Full width cards
            _fullWidthCard(),
            const SizedBox(height: 12),
            _fullWidthCard(),
            const SizedBox(height: 12),
            _fullWidthCard(),
          ],
        ),
      ),
    );
  }

  Widget _topCard() {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: greyColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: lightColor,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10, width: 80, color: lightColor),
                const SizedBox(height: 8),
                Container(height: 12, width: 50, color: lightColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _fullWidthCard() {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: greyColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: lightColor,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 12,
              color: lightColor,
            ),
          ),
          const SizedBox(width: 30),
          Container(
            height: 12,
            width: 20,
            color: lightColor,
          ),
        ],
      ),
    );
  }
}
