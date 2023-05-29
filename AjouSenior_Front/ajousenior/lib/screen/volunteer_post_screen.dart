import 'package:ajousenior/models/senior_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:ajousenior/widgets/textfield_widget.dart';
import 'package:http/http.dart' as http;

class VolunteerPostScreen extends StatefulWidget {
  const VolunteerPostScreen({super.key});
  @override
  State<VolunteerPostScreen> createState() => _VolunteerPostScreenState();
}

class _VolunteerPostScreenState extends State<VolunteerPostScreen> {
  final centerarea = TextEditingController();
  final contentarea = TextEditingController();
  final memberarea = TextEditingController();
  DateTime date = DateTime.now();
  static const storage = FlutterSecureStorage();
  dynamic userInfo = '';
  late Senior user;
  // storage에 있는 유저 정보를 저장
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
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Center(
          child: Text(
            "신청",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AdvancedTextField(
              controller: contentarea,
              labelText: '내용',
              hintText: '내용',
            ),
            /*const SizedBox(
              height: 10,
            ),
            AdvancedTextField(
              controller: centerarea,
              labelText: 'seniorcenter',
              hintText: 'seniorcenter',
            ),*/
            const SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]'))
              ],
              controller: memberarea,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '인원 수',
                hintText: '인원 수',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '날짜',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2099),
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                    );
                    if (selectedDate != null) {
                      setState(() {
                        date = selectedDate;
                      });
                    }
                  },
                  child: const Text('날짜 선택'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    /*Post newPost = Post(
                      title: titlearea.text,
                      content: contentarea.text,
                      date: '2023-03-26',
                      userID: 'user1',
                    );
                    posts.insert(0, newPost);
                    Navigator.pop(context);*/
                    user = StringTo(userInfo);
                    var data = {
                      "seniorcenter": user.seniorcenter,
                      "writer": user.profile_nickname,
                      "date": DateFormat.yMMMd().format(date),
                      "content": contentarea.text,
                      "maxpeople": int.tryParse(memberarea.text),
                      "currentpeople": 0
                    };
                    var body = json.encode(data);
                    http.Response res = await http.post(
                      Uri.parse(
                          "http://54.180.8.70:4000/talentdonation/upload"),
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
                  child: const Text("신청"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
