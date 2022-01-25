import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.maxFinite,
      // color: Colors.amber,
      child: Center(
        child: FadeInDown(
          // duration: defaultAnimationTime,
          child: Text(
            "Hi,\nBuddy",
            softWrap: true,
            style: TextStyle(
                fontFamily: GoogleFonts.nunitoSans().fontFamily,
                color: Colors.grey.shade700),
            textAlign: TextAlign.center,
            textScaleFactor: 2.5,
          ),
        ),
      ),
    );
  }
}
