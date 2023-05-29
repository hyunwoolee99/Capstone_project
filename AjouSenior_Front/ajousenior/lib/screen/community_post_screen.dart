import 'package:ajousenior/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ajousenior/models/senior_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final titlearea = TextEditingController();
  final contentarea = TextEditingController();
  static var storage = const FlutterSecureStorage();
  dynamic userInfo = '';
  late Senior user;
  @override
  void initState() {
    super.initState();
    // 비동기로 flutter secure storage 정보를 불러오는 작업
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
      if (userInfo != '') {
        user = StringTo(userInfo);
      }
    });
  }

  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    userInfo = await storage.read(key: 'login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Center(
          child: Text(
            "Senior App",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            AdvancedTextField(
              controller: titlearea,
              labelText: 'Title',
              hintText: 'Title',
            ),
            const SizedBox(
              height: 10,
            ),
            AdvancedTextField(
              controller: contentarea,
              multiline: true,
              maxLines: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    user = StringTo(userInfo);
                    var data = {
                      "title": titlearea.text,
                      "content": contentarea.text,
                      "writer": user.profile_nickname,
                      "date": DateFormat.yMMMd().format(DateTime.now()),
                    };
                    var body = json.encode(data);
                    http.Response res = await http.post(
                      Uri.parse("http://54.180.8.70:4000/community/upload"),
                      headers: {"Content-Type": "application/json"},
                      body: body,
                    );
                    print(body);
                    if (res.statusCode == 200) {
                      Navigator.pop(context);
                    } else {
                      throw Exception('post failed');
                    }
                  },
                  child: const Text("post"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
