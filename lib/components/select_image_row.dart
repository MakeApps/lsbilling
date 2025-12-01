import 'dart:io';

import 'package:flutter/material.dart';
import 'package:local_shout_billing/components/custom_width.dart';
import 'package:local_shout_billing/components/display_selected_image.dart';
import 'package:local_shout_billing/components/select_image_title.dart';
import 'package:local_shout_billing/config/colors.dart';

class SelectImageRow extends StatelessWidget {
  final Function takeCameraImage;
  final File imageFile;
  final String title;
  final String existedImageUrl;
  final VoidCallback onRemoveImage;

  const SelectImageRow({
    super.key,
    required this.takeCameraImage,
    required this.imageFile,
    required this.title,
    this.existedImageUrl = "",
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 17, top: 15, bottom: 15),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectImageTitle(title: title),
              ElevatedButton.icon(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  backgroundColor:
                      const WidgetStatePropertyAll(successDarkColor),
                ),
                icon:
                    const Icon(Icons.upload_file, color: whiteColor, size: 18),
                onPressed: () => takeCameraImage(imageFile),
                label: const Text(
                  'Upload Image',
                  style: TextStyle(fontSize: 14, color: whiteColor),
                ),
              ),
            ],
          ),
          const CustomWidth(width: 60),
          DisplaySelectedImage(
            imageFile: imageFile,
            existedImageUrl: existedImageUrl,
            onRemove: onRemoveImage,
          ),
        ],
      ),
    );
  }
}
