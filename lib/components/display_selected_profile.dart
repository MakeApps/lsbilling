import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';

class DisplaySelectedProfile extends StatelessWidget {
  final File imageFile;
  final String existedImageUrl;
  const DisplaySelectedProfile(
      {super.key, required this.imageFile, this.existedImageUrl = ""});
  @override
  Widget build(BuildContext context) {
    return (imageFile.path != "")
        ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              imageFile,
              // height: 70,
              // width: 70,
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
            ),
          )
        : (existedImageUrl.isNotEmpty)
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: existedImageUrl,
                  // height: 70,
                  // width: 70,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 250,
                    width: 164,
                    color: whiteColor,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    return const Icon(imageNotSupport,
                        size: 68, color: hintTextColor);
                  },
                ),
              )
            : const Icon(bill, size: 70, color: hintTextColor);
    // );
  }
}
