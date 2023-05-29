import 'package:ajousenior/models/senior_model.dart';
import 'package:ajousenior/widgets/hidelogin_widget.dart';
import 'package:ajousenior/widgets/hidelogin_widget2.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import 'findcenter_screen.dart';

class SeniorLoginScreen extends StatefulWidget {
  const SeniorLoginScreen({super.key});

  @override
  State<SeniorLoginScreen> createState() => _SeniorLoginScreenState();
}

class _SeniorLoginScreenState extends State<SeniorLoginScreen> {
  void _get_user_info() async {
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          '\n닉네임: ${user.kakaoAccount?.ageRange}'); //닉네임,이메일,성별,나이,센터,생일//
      Senior S = Senior(
          user.kakaoAccount?.profile?.nickname,
          user.kakaoAccount?.email,
          user.kakaoAccount?.gender.toString(),
          user.kakaoAccount?.ageRange.toString(),
          '',
          user.kakaoAccount?.birthday,
          '');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FindCenterWidget(S))); // FindCenterScreen()
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("카카오 로그인을 기본으로 제공하고 있습니다",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 80,
              ), //assets/kakaopic.png
              IconButton(
                  icon: Image.asset('assets/kakaopic.png'),
                  iconSize: 150,
                  style: const ButtonStyle(),
                  onPressed: () async {
                    if (await isKakaoTalkInstalled()) {
                      try {
                        await UserApi.instance.loginWithKakaoTalk();
                        print('카카오톡으로 로그인 성공');
                        _get_user_info();
                      } catch (error) {
                        print('카카오톡으로 로그인 실패 $error');
                        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                        try {
                          await UserApi.instance.loginWithKakaoAccount();
                          print('카카오계정으로 로그인 성공');
                          _get_user_info();
                        } catch (error) {
                          print('카카오계정으로 로그인 실패 $error');
                        }
                      }
                    } else {
                      try {
                        await UserApi.instance.loginWithKakaoAccount();
                        print('카카오계정으로 로그인 성공');
                        _get_user_info();
                      } catch (error) {
                        print('카카오계정으로 로그인 실패 $error');
                      }
                    }
                  }),
              const SizedBox(
                height: 100,
              ),
              const LoginWidget(),
              const SizedBox(
                height: 5,
              ),
              const LoginWidget2(),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
