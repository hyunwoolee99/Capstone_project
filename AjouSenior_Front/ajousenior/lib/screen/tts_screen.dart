import 'package:ajousenior/models/tts.dart';
import 'package:flutter/material.dart';

class TTSScreen extends StatelessWidget {
  const TTSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("TTS"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: textController,
          ),
          ElevatedButton(
              onPressed: () {
                TextToSpeech.speak(textController.text);
              },
              child: const Text('Speak')),
        ],
      ),
    );
  }
}
