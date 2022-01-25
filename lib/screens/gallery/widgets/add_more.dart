import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddMoreGalleryWidget extends StatelessWidget {
  const AddMoreGalleryWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Iconsax.add,
                  size: 50,
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Add More")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
