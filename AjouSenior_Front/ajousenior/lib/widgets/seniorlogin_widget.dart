import 'package:ajousenior/data/Seniordata.dart';
import 'package:ajousenior/models/senior_model.dart';
import 'package:ajousenior/screen/senior_screen.dart';
import 'package:ajousenior/screen/seniorlogin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screen/junior_screen.dart';

class SeniorLogin extends StatefulWidget {
  const SeniorLogin({super.key});

  @override
  State<SeniorLogin> createState() => _SeniorLoginState();
}

class _SeniorLoginState extends State<SeniorLogin> {
  static const storage = FlutterSecureStorage();
  dynamic userInfo = ''; // storage에 있는 유저 정보를 저장

  //flutter_secure_storage 사용을 위한 초기화 작업
  @override
  void initState() {
    super.initState();
    // 비동기로 flutter secure storage 정보를 불러오는 작업
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    userInfo = await storage.read(key: 'login');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (userInfo == null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SeniorLoginScreen(),
            ),
          );
        } else {
          print(userInfo);
          Senior a = StringTo(userInfo); //사용예시
          SeniorData.senior = a;
          String lastTwoDigits =
              a.age_range!.substring(a.age_range!.length - 2);
          int lastTwoDigitsAsInt = int.parse(lastTwoDigits);
          print(lastTwoDigitsAsInt);
          if (lastTwoDigitsAsInt > 60) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SeniorScreen(),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const JuniorScreen(),
              ),
            );
          }
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: const Color.fromARGB(255, 20, 146, 9).withOpacity(0.3),
                offset: const Offset(3, 3))
          ],
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
        ),
        height: 50,
        width: 100,
        child: Text('로그인',
            style: GoogleFonts.notoSansKannada(
              fontSize: 20,
              color: Theme.of(context).colorScheme.outline,
            )),
      ),
    );
  }
}
