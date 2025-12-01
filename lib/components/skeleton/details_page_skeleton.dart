import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/colors.dart'; // Ensure your color constants are correctly imported

class DetailsPageSkeleton extends StatelessWidget {
  const DetailsPageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 1.8,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5)
            ),
            child: Shimmer.fromColors(
                baseColor: greyColor.withOpacity(0.1),
                highlightColor: hintTextColor,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          // width: 250,
                          color: greyColor,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              color: greyColor,
                            )
                          ],
                        ),
                          Row(
                          children: [
                            Container(
                              height: 20,
                              color: greyColor,
                            )
                          ],
                        ),
                          Row(
                          children: [
                            Container(
                              height: 20,
                              color: greyColor,
                            )
                          ],
                        ),
                          Row(
                          children: [
                            Container(
                              height: 20,
                              color: greyColor,
                            )
                          ],
                        ),
                      ],
                    ))),
          ),
        ],
      ),
    );
  }
}

// Expanded(
                            //   child: Container(
                            //     child: Padding(
                            //       padding: const EdgeInsets.only(
                            //           left: 5, right: 5, top: 0, bottom: 0),
                            //       child: Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.start,
                            //         children: <Widget>[
                            //           Row(
                            //             children: <Widget>[
                            //               Expanded(
                            //                 child: Container(
                            //                   child: Column(
                            //                       crossAxisAlignment:
                            //                           CrossAxisAlignment.start,
                            //                       mainAxisAlignment:
                            //                           MainAxisAlignment.start,
                            //                       children: [
                            //                         Row(
                            //                             mainAxisAlignment:
                            //                                 MainAxisAlignment
                            //                                     .spaceBetween,
                            //                             children: [
                            //                               Container(
                            //                                   width: 150,
                            //                                   height: 20,
                            //                                   color:
                            //                                       lightColor),
                                                          
                            //                             ]),
                            //                         const SizedBox(height: 12),
                            //                         Container(
                            //                             width: double.infinity,
                            //                             height: 20,
                            //                             color: lightColor),
                            //                         const SizedBox(height: 12),
                            //                         Container(
                            //                             width: double.infinity,
                            //                             height: 20,
                            //                             color: lightColor),
                            //                         const SizedBox(height: 12),
                            //                         Container(
                            //                             width: double.infinity,
                            //                             height: 20,
                            //                             color: lightColor),
                            //                       ]),
                            //                   //  ),
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),