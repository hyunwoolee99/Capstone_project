import 'package:ajousenior/widgets/juniorkakao_widget.dart';
import 'package:flutter/material.dart';

class JuniorLoginScreen extends StatelessWidget {
  const JuniorLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [JuniorKakao()],
      ),
    );
  }
}
