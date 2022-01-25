import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scanner/constants.dart';
import 'package:scanner/core/provider.camera.dart';
import 'package:scanner/core/provider.gallery.dart';
import 'package:scanner/core/provider.make_pdf.dart';
import 'package:scanner/models/files.dart';
import 'package:scanner/screens/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  // ? establish hive db
  await Hive.initFlutter();
  Hive.registerAdapter<CreatedFile>(CreatedFileAdapter());
  await Hive.openBox<CreatedFile>(boxName);
  
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => CustomCameraPageHandler(),
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) => CustomGalleryPageHandler(),
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) => MakePdfPageHandler(),
      ),
    ],
    child: const RxScanner(),
  ));
}

class RxScanner extends StatelessWidget {
  const RxScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false, // later be removed
      theme: ThemeData(
          fontFamily: GoogleFonts.nunito().fontFamily,
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              elevation: 0.0,
              color: Colors.transparent,
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
              iconTheme: IconThemeData(color: Colors.black))),
      home: const HomePage(),
    );
  }
}
