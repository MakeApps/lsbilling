import 'dart:io';
import 'package:local_shout_billing/components/display_selected_profile.dart';
import '../../modules/job_sheet/pages/job_sheet.dart';

class SelectProfileImage extends StatelessWidget {
  final Function(ImageSource)? takeImage;
  //final Function takeCameraImage;
  final File imageFile;
  final String existedImageUrl;

  const SelectProfileImage(
      {super.key,
      required this.imageFile,
      this.existedImageUrl = '',
      this.takeImage});

  @override
  Widget build(BuildContext context) {
    double widthPixel = 100;
    double heightPixel = 100;

    return GestureDetector(
      onTap: () => (showImageSource(context)),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          CircleAvatar(
            backgroundColor: blackColor,
            radius: widthPixel / 2,
            child: ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(53),
                child: DisplaySelectedProfile(
                  imageFile: imageFile,
                  existedImageUrl: existedImageUrl,
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: -14,
            bottom: -14,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: widthPixel / 2.2,
                  height: heightPixel / 2.5,
                  child: CircleAvatar(
                    backgroundColor: primaryColor,
                    radius: MediaQuery.of(context).size.width * 0.05,
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          (showImageSource(context));
                        },
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                        ),
                        color: blackColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showImageSource(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          title: const Center(
            child: Text(
              "Select Image From",
              style: TextStyle(color: blackColor, fontSize: 14),
            ),
          ),
          content: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    takeImage!(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera_alt, color: greyColor),
                  label: const Text(
                    "Camera",
                    style: TextStyle(color: blackColor, fontSize: 14),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    takeImage!(ImageSource.gallery);
                  },
                  icon: const Icon(
                    Icons.photo,
                    color: greyColor,
                  ),
                  label: const Text(
                    "Gallary",
                    style: TextStyle(color: blackColor, fontSize: 14),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
