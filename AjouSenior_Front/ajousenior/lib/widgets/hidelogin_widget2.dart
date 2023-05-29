import 'package:ajousenior/data/Seniordata.dart';
import 'package:ajousenior/models/senior_model.dart';
import 'package:ajousenior/screen/senior_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/login_service.dart';

class LoginWidget2 extends StatefulWidget {
  const LoginWidget2({super.key});

  @override
  State<LoginWidget2> createState() => _LoginWidget2State();
}

class _LoginWidget2State extends State<LoginWidget2> {
  static const storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    logIn() async {
      final id = await LoginService.sendLogin('시니어', 'senior@naver.com', 'null',
          'AgeRange.age_60_69', '우만주공2단지경로당', '0415');
      storage.write(
        key: 'login',
        value:
            '시니어//senior@naver.com//null//AgeRange.age_60_69//우만주공2단지경로당//0415//' +
                id,
      );
      // ignore: prefer_interpolation_to_compose_strings
      SeniorData.senior = StringTo(
          '시니어//senior@naver.com//null//AgeRange.age_60_69//우만주공2단지경로당//0415//' +
              id);
    }

    return GestureDetector(
      onTap: () {
        logIn();
        print("로그인 성공");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SeniorScreen(),
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
        child: Text('시니어 로그인',
            style: GoogleFonts.notoSansKannada(
              fontSize: 10,
              color: Theme.of(context).colorScheme.outline,
            )),
      ),
    );
  }
}
