import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/colors.dart'; // Ensure your color constants are correctly imported

class Skeleton extends StatelessWidget {
  const Skeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Shimmer.fromColors(
        baseColor: greyColor.withOpacity(0.1),
        highlightColor: lightColor,
        child: ListView.builder(
          itemCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: hintTextColor),
                ),
                margin: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        color: lightColor,
                        height: 140.0,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        color: lightColor,
                        height: 140.0,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        color: lightColor,
                        height: 140.0,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
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