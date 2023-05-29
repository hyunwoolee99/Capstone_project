// 승수//seungsu8826@naver.com//null//AgeRange.age_20_29//우만주공1단지경로당//0311//643a5d66fbc5fd3feb88cfc5

import 'package:ajousenior/models/senior_model.dart';
import 'package:ajousenior/screen/junior_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/Seniordata.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  static const storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    logIn() async {
      storage.write(
        key: 'login',
        value:
            '승수//seungsu8826@naver.com//null//AgeRange.age_20_29//우만주공2단지경로당//0311//645225a92229f4c11b87b592',
      );
    }

    return GestureDetector(
      onTap: () {
        SeniorData.senior = StringTo(
            '승수//seungsu8826@naver.com//null//AgeRange.age_20_29//우만주공2단지경로당//0311//645225a92229f4c11b87b592');
        logIn();
        print("로그인 성공");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const JuniorScreen(),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(2, 2))
          ],
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
        ),
        height: 40,
        width: 70,
        child: Text('주니어 로그인',
            style: GoogleFonts.notoSansKannada(
              fontSize: 10,
              color: Theme.of(context).colorScheme.outline,
            )),
      ),
    );
  }
}
