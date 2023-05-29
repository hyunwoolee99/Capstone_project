import 'package:ajousenior/models/tts.dart';
import 'package:ajousenior/screen/mainlogin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "key.env");
  TextToSpeech.initTTS();
  KakaoSdk.init(nativeAppKey: '12250f8b8c7be3e149c3bf627eda1f5c');
  runApp(const MyApp());
}

const seedColor = Color.fromARGB(255, 18, 219, 105);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: seedColor, brightness: Brightness.light),
          textTheme: GoogleFonts.notoSansNKoTextTheme(
            Theme.of(context).textTheme,
          )),
      home: const MainLogin(),
    );
  }
}
