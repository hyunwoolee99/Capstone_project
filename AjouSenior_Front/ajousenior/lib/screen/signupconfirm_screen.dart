import 'package:ajousenior/models/senior_model.dart';
import 'package:ajousenior/screen/junior_screen.dart';
import 'package:ajousenior/screen/senior_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../services/login_service.dart';

class SignUpConfirm extends StatefulWidget {
  final Senior data;
  const SignUpConfirm(this.data, {super.key});
  @override
  State<SignUpConfirm> createState() => _SignUpConfirmState();
}

class _SignUpConfirmState extends State<SignUpConfirm> {
  static const storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입 확인'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(color: Colors.green, width: 1.0),
              ),
              elevation: 4.0,
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('정보 확인 후 회원가입 완료를 눌러주세요',
                        style: TextStyle(fontSize: 20.0, color: Colors.green)),
                    const SizedBox(height: 16.0),
                    const Text('이름', style: TextStyle(fontSize: 20.0)),
                    Text('${widget.data.profile_nickname}',
                        style: const TextStyle(fontSize: 24.0)),
                    const SizedBox(height: 16.0),
                    const Text('이메일', style: TextStyle(fontSize: 20.0)),
                    Text('${widget.data.account_email}',
                        style: const TextStyle(fontSize: 24.0)),
                    const SizedBox(height: 16.0),
                    const Text('나이', style: TextStyle(fontSize: 20.0)),
                    Text('${widget.data.age_range}',
                        style: const TextStyle(fontSize: 24.0)),
                    const SizedBox(height: 16.0),
                    const Text('시니어 센터', style: TextStyle(fontSize: 20.0)),
                    Text('${widget.data.seniorcenter}',
                        style: const TextStyle(fontSize: 24.0)),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final id = await LoginService.sendLogin(
                    widget.data.profile_nickname,
                    widget.data.account_email,
                    widget.data.gender,
                    widget.data.age_range,
                    widget.data.seniorcenter,
                    widget.data.birthday);
                widget.data.id = id;
                await storage.write(
                  key: 'login',
                  value: widget.data.toString(),
                );
                String lastTwoDigits = widget.data.age_range!
                    .substring(widget.data.age_range!.length - 2);
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
              },
              child: const Text('가입완료'),
            )
          ],
        ),
      ),
    );
  }
}
