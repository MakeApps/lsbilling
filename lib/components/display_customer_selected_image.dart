import 'dart:io';
import 'package:local_shout_billing/modules/job_sheet/pages/job_sheet.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;

class DisplayCustomerSelectedImage extends StatelessWidget {
  final File imageFile;
  final String existedImageUrl;
  const DisplayCustomerSelectedImage(
      {super.key, required this.imageFile, this.existedImageUrl = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.8, color: borderColor),
      ),
      child: (imageFile.path != "")
          ? _buildImageWidget(imageFile)
          : (existedImageUrl.isNotEmpty)
              ? _buildNetworkImageWidget(existedImageUrl)
              : const Icon(bill, size: 70, color: hintTextColor),
    );
  }

  Widget _buildImageWidget(File file) {
    try {
      // Check if the selected file is a PDF
      if (file.path.endsWith('.pdf')) {
        return const Icon(Icons.picture_as_pdf, size: 50, color: Colors.red);
      } else {
        // Handle image files
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            file,
            height: 70,
            width: 70,
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(imageNotSupport,
                  size: 68, color: hintTextColor);
            },
          ),
        );
      }
    } catch (e) {
      return const Icon(imageNotSupport, size: 68, color: hintTextColor);
    }
  }

  Widget _buildNetworkImageWidget(String url) {
    if (url.endsWith('.pdf')) {
      return const Icon(Icons.picture_as_pdf, size: 50, color: Colors.red);
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: url,
          height: 70,
          width: 70,
          filterQuality: FilterQuality.high,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) {
            return const Icon(imageNotSupport, size: 68, color: hintTextColor);
          },
        ),
      );
    }
  }
}
