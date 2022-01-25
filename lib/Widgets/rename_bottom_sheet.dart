import 'package:flutter/material.dart';
import 'package:scanner/Widgets/dargline.dart';
import 'package:scanner/extensions/ext.details.dart';

class CustomRenameBottomSheet extends StatefulWidget {
  const CustomRenameBottomSheet(
      {Key? key, required this.title, required this.onSave})
      : super(key: key);

  final String title;
  final Function onSave;

  @override
  State<CustomRenameBottomSheet> createState() =>
      _CustomRenameBottomSheetState();
}

class _CustomRenameBottomSheetState extends State<CustomRenameBottomSheet> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController(text: widget.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    return Container(
      // height: 100,
      padding: EdgeInsets.only(top: context.responsive(14)),
      width: double.maxFinite,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const DragLine(),
          Flexible(
            child: Padding(
                padding: EdgeInsets.only(
                  left: 26,
                  right: 26,
                  top: context.responsive(14),
                  bottom: context.responsive(14) + viewInsets + safeAreaBottom,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        autofocus: true,
                        controller: _textEditingController,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 1,
                      height: 20,
                      decoration: const ShapeDecoration(
                        shape: StadiumBorder(),
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                        onPressed: () {
                          widget.onSave(_textEditingController.text);
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.done))
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
