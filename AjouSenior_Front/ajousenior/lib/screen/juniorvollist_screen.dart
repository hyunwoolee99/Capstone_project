import 'package:ajousenior/screen/junior_screen.dart';
import 'package:ajousenior/services/volunteerlist_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ajousenior/screen/map_sample.dart';

import '../models/senior_model.dart';
import '../services/junior_postvolunteer.dart';

class VolunteerListScreen extends StatefulWidget {
  const VolunteerListScreen({Key? key}) : super(key: key);

  @override
  State<VolunteerListScreen> createState() => _VolunteerListScreenState();
}

class _VolunteerListScreenState extends State<VolunteerListScreen> {
  static const storage = FlutterSecureStorage();
  dynamic userInfo = '';
  // storage에 있는 유저 정보를 저장

  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    userInfo = await storage.read(key: 'login');
    print(userInfo + "를 읽어왔습니다");
  }

  List<Map<String, dynamic>> locations = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
    _loadLocations();
  }

  void _loadLocations() async {
    try {
      final list = await GetVolListService().getVolList();
      setState(() {
        locations = list.cast<Map<String, dynamic>>();
        print("성공");
      });
    } catch (e) {}
  }

  Future<bool?> _showApplyDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("신청하시겠습니까?"),
          actions: <Widget>[
            TextButton(
              child: const Text("예"),
              onPressed: () => Navigator.of(context).pop(true),
            ),
            TextButton(
              child: const Text("아니오"),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false; // 뒤로가기 버튼을 무시하고 아무 동작도 하지 않음
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                // 홈 버튼을 눌렀을 때 수행할 동작
                // 예를 들어, 홈 화면으로 이동하는 코드를 작성할 수 있습니다.
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const JuniorScreen()));
              },
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.green,
            title: const Text('        재능기부 리스트'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.map_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapScreen()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.list_alt),
                onPressed: () {
                  print('리스트 화면으로 전환');
                },
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 237, 255, 240),
          body: ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                final location = locations[index];
                return ListTile(
                  title: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 9.0,
                          color: Colors.green,
                        ),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                location['seniorcenter'],
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("내용 : " + location['content']),
                              Text("시간 : "
                                  "${DateTime.parse(location['date']).month}월${DateTime.parse(location['date']).day}일${DateTime.parse(location['date']).hour}시${DateTime.parse(location['date']).minute}분"),
                              Text("최대 인원: ${location['maxpeople']}"),
                              Text("현재 인원: ${location['currentpeople']}"),
                            ],
                          ),
                          if (location['currentpeople'] < location['maxpeople'])
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green), // 배경색 변경
                              ),
                              onPressed: () async {
                                Senior a = StringTo(userInfo);
                                print(userInfo);
                                final apply = await _showApplyDialog();
                                if (apply == true) {
                                  JuniorPostVolunteer.sendVolunteer(
                                      location['_id'],
                                      a.id,
                                      location['currentpeople'].toString());
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              super.widget));
                                }
                              },
                              child: const Text('신청'),
                            )
                          else
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red), // 배경색 변경
                                ),
                                onPressed: () async {},
                                child: const Text('인원 초과'))
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}
