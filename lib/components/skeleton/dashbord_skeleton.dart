import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/colors.dart';

class DashboardSkeleton extends StatelessWidget {
  const DashboardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Shimmer.fromColors(
        baseColor: greyColor.withOpacity(0.1),
        highlightColor: lightColor,
        child: ListView.builder(
          itemCount: 1,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: blackColor),
                    ),
                    margin: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Container(
                          color: hintTextColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Card(
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 5, top: 5),
                                    child: Container(
                                      width: 140,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: blueColor),
                                        color: lightColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 70,
                                            color: lightColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Card(
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 5, top: 5),
                                    child: Container(
                                      width: 140,
                                      padding: const EdgeInsets.only(
                                          left: 23,
                                          right: 23,
                                          top: 8,
                                          bottom: 8),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: successColor),
                                        color: lightColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 70,
                                            color: lightColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        itemBuilder: (context, index) {
                          return Card(
                            color: greyColor.withOpacity(0.3),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Container(
                              width: 160,
                              height: 60,
                              decoration: BoxDecoration(
                                color: greyColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          color: pinkColor,
                          child: Container(
                            margin: const EdgeInsets.only(top: 16, bottom: 16),
                            child: Column(
                              children: [
                                Container(
                                  height: 150,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: greyColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: primaryYellowColor,
                          child: Container(
                            margin: const EdgeInsets.only(top: 16, bottom: 16),
                            child: Column(
                              children: [
                                Container(
                                  height: 150,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: greyColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: purpleColor,
                          child: Container(
                            margin: const EdgeInsets.only(top: 16, bottom: 16),
                            child: Column(
                              children: [
                                Container(
                                  height: 150,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: greyColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
