import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ajousenior/models/senior_model.dart';
import 'package:http/http.dart' as http;

class CertifyService {
  var url = Uri.parse("http://54.180.8.70:4000/senior/talentdonationconfirm");
  final BuildContext context;

  CertifyService(this.context);
  certify(String donationid, Senior user) async {
    var data = {"donationid": donationid, "userid": user.id};
    var body = json.encode(data);
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      print('certify');
      _showCertificationPopup(user.profile_nickname!);
      AlertDialog(
        title: const Text('인증 완료'),
        content: Text('${user.profile_nickname}님의 인증이 완료되었습니다.'),
      );
    } else {
      throw Exception('fail');
    }
  }

  void _showCertificationPopup(String username) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('인증 완료'),
          content: Text('$username님의 인증이 완료되었습니다.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
