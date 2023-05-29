import 'package:ajousenior/models/chat_model.dart';
import 'package:ajousenior/models/tts.dart';
import 'package:ajousenior/screen/senior_screen.dart';
import 'package:ajousenior/services/gpt_service.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  SpeechToText speechToText = SpeechToText();
  var text = "버튼을 누르면서 말해주세요";
  var isListening = false;

  final List<ChatMessage> messages = [];

  var scrollController = ScrollController();

  scrollMethod() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 5000), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // 뒤로가기 버튼을 무시하고 아무 동작도 하지 않음
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          endRadius: 75.0,
          animate: isListening,
          duration: const Duration(milliseconds: 2000),
          glowColor: Theme.of(context).colorScheme.secondaryContainer,
          repeat: true,
          repeatPauseDuration: const Duration(milliseconds: 100),
          showTwoGlows: true,
          child: GestureDetector(
            onTapDown: (details) async {
              if (!isListening) {
                var available = await speechToText.initialize();
                if (available) {
                  setState(() {
                    isListening = true;
                    speechToText.listen(
                      onResult: (result) {
                        setState(() {
                          text = result.recognizedWords;
                        });
                      },
                    );
                  });
                }
              }
            },
            onTapUp: (details) async {
              setState(() {
                isListening = false;
              });
              await speechToText.stop();

              if (text.isNotEmpty && text != "버튼을 누르면서 말해주세요") {
                messages
                    .add(ChatMessage(text: text, type: ChatMessageType.user));
                var msg = await GptService.sendMessage(text);
                msg = msg.trim();
                setState(() {
                  messages
                      .add(ChatMessage(text: msg, type: ChatMessageType.bot));
                });

                Future.delayed(const Duration(milliseconds: 500), () {
                  TextToSpeech.speak(msg);
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Failed to Process try again")));
              }
            },
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              radius: 35,
              child: Icon(
                isListening ? Icons.mic : Icons.mic_none,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
          leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              // 홈 버튼을 눌렀을 때 수행할 동작
              // 예를 들어, 홈 화면으로 이동하는 코드를 작성할 수 있습니다.
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SeniorScreen()));
            },
          ),
          centerTitle: true,
          elevation: 2,
          title: Text(
            '세나',
            style: GoogleFonts.notoSansKannada(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Text(
                text,
                style: GoogleFonts.notoSansKannada(
                  fontSize: 27,
                  color: isListening
                      ? Colors.black
                      : const Color.fromARGB(255, 121, 120, 120),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.green.withOpacity(0.13),
                  ),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        var chat = messages[index];

                        return chatBubble(chattext: chat.text, type: chat.type);
                      }),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget chatBubble({required chattext, required ChatMessageType? type}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar(
        backgroundColor: Colors.green.withOpacity(0.13),
        child: type == ChatMessageType.bot
            ? Image.asset('assets/ChatGPTIcon.png')
            : const Icon(
                Icons.person,
                color: Color.fromARGB(255, 145, 91, 10),
              ),
      ),
      const SizedBox(
        width: 12,
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: type == ChatMessageType.bot
                ? Colors.blueGrey
                : const Color.fromARGB(75, 155, 95, 18),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12)),
          ),
          child: Text(
            "$chattext",
            style: GoogleFonts.notoSansKannada(
              fontSize: 15,
              color:
                  type == ChatMessageType.bot ? Colors.black87 : Colors.black45,
              fontWeight: type == ChatMessageType.bot
                  ? FontWeight.w600
                  : FontWeight.w400,
            ),
          ),
        ),
      ),
    ],
  );
}
