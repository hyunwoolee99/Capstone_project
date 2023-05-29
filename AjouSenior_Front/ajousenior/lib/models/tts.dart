import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  static FlutterTts tts = FlutterTts();

  static initTTS() async {
    print(await tts.getLanguages); //어떤 언어 사용가능?

    tts.setLanguage("ko-KR"); //ko-KR한국어 사용 경우
    tts.setPitch(0.8); //피치설정
    tts.setSpeechRate(0.5); //말하는 속도
    tts.setVolume(1);
  }

  static speak(String text) async {
    tts.setStartHandler(() {
      print("TTS IS STARTED");
    });

    tts.setCompletionHandler(() {
      print("COMPLETED");
    });

    tts.setErrorHandler((message) {
      print(message);
    });

    await tts.awaitSpeakCompletion(true);

    tts.speak(text);
  }
}
