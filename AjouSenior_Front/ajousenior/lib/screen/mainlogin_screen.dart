import 'dart:async';

import 'package:ajousenior/widgets/seniorlogin_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MainLogin extends StatefulWidget {
  const MainLogin({super.key});

  @override
  State<MainLogin> createState() => _MainLoginState();
}

class _MainLoginState extends State<MainLogin> with TickerProviderStateMixin {
  bool visible1 = false;
  bool visible2 = false;
  bool visible3 = false;
  bool visible4 = false;

  final bool _showText = true;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      setState(() {
        visible1 = true;
      });
    });
    Timer(const Duration(seconds: 3), () {
      setState(() {
        visible2 = true;
      });
    });
    Timer(const Duration(seconds: 4), () {
      setState(() {
        visible3 = true;
      });
    });
    Timer(const Duration(seconds: 4), () {
      setState(() {
        visible4 = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: visible1 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: const Text(
              'SENA',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          AnimatedOpacity(
            opacity: visible2 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Lottie.asset("assets/26919-happy-grandma-and-grandpa.json",
                repeat: true),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AnimatedOpacity(
                  opacity: visible3 ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: const SeniorLogin()),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          AnimatedOpacity(
            opacity: visible4 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: GestureDetector(
              // onTap: ,
              child: const Text(
                '시작하시려면 \'로그인\' 을 한번 클릭해 주세요',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
