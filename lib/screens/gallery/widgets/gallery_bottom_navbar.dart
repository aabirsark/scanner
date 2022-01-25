import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:scanner/core/provider.gallery.dart';
import 'package:scanner/screens/gallery/utils/gallery_tools.dart';
import 'package:scanner/screens/gallery/widgets/gallery_bottom_bar_button.dart';

class GalleryBottomNavBar extends StatefulWidget {
  const GalleryBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<GalleryBottomNavBar> createState() => _GalleryBottomNavBarState();
}

class _GalleryBottomNavBarState extends State<GalleryBottomNavBar> {
  repick() async {
    var pr = context.read<CustomGalleryPageHandler>();
    final XFile? file =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      pr.exhangeImageAtIndex(pr.pageSliderNo, file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      // color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: tools
            .map((e) => InkWell(
                  onTap: () {
                    switch (e.toolSynopsis) {
                      case "Remove":
                        var pr = context.read<CustomGalleryPageHandler>();
                        pr.removeImageIndex(pr.pageSliderNo);
                        break;

                      case "Re-pick":
                        repick();
                        break;
                      default:
                    }
                  },
                  child: GalleryBottomBar(
                    e: e,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
