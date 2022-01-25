import 'package:flutter/material.dart';


class DragLine extends StatelessWidget {
  const DragLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.2;

    return Container(
      width: width,
      height: 2,
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        color: Colors.black45,
      ),
    );
  }
}
