import 'dart:io';

import 'package:flutter/material.dart';
import 'package:local_shout_billing/config/app_icons.dart';
import 'package:local_shout_billing/config/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DisplaySelectedImage extends StatelessWidget {
  final File imageFile;
  final String existedImageUrl;
  final VoidCallback onRemove;

  const DisplaySelectedImage({
    super.key,
    required this.imageFile,
    this.existedImageUrl = "",
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imageFile.path.isNotEmpty || existedImageUrl.isNotEmpty;
    return Stack(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.8, color: borderColor),
          ),
          child: (imageFile.path != "")
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    imageFile,
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                )
              : (existedImageUrl.isNotEmpty)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: existedImageUrl,
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Icon(
                            imageNotSupport,
                            size: 68,
                            color: hintTextColor),
                      ),
                    )
                  : const Icon(bill, size: 70, color: hintTextColor),
        ),
        if (hasImage)
          Positioned(
            right: 1,
            top: 1,
            child: Container(
              height: 21,
              width: 21,
              decoration: const BoxDecoration(
                color: blackColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: InkWell(
                onTap: onRemove,
                borderRadius: BorderRadius.circular(11),
                child: const Icon(
                  Icons.close,
                  size: 15,
                  color: whiteColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
