import 'package:ajousenior/data/Seniordata.dart';
import 'package:ajousenior/models/senior_model.dart';
import 'package:ajousenior/widgets/logout_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data/volunteer_post.dart';
import '../provider/volunteerprovider.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  static var storage = const FlutterSecureStorage();
  dynamic userInfo = '';

  Widget body = const Center(
    child: CircularProgressIndicator(),
  );

  Future<void> _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    userInfo = await storage.read(key: 'login');
    Senior a = SeniorData.senior;
    setState(() {
      if (a == null) {
        body = const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        // userInfo가 값이 있는 경우 body를 구성하는 코드
        body = Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                height: 135,
                width: double.maxFinite,
                child: Card(
                  elevation: 5,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 3.0,
                          color: Colors.green,
                        ),
                        right: BorderSide(
                          width: 3.0,
                          color: Colors.green,
                        ),
                        bottom: BorderSide(
                          width: 3.0,
                          color: Colors.green,
                        ),
                        left: BorderSide(
                          width: 3.0,
                          color: Colors.green,
                        ),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 95,
                                height: 95,
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 80,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '이름 : ${a.profile_nickname}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    '이메일 :  ${a.account_email!}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '경로당 이름 :  ${a.seniorcenter!}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<VolunteerPost>>(
                  future: VolunteerProviders().getlastPost(a.profile_nickname),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Container(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              height: 130,
                              width: double.maxFinite,
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        width: 9.0,
                                        color: snapshot
                                                    .data![
                                                        snapshot.data!.length -
                                                            index -
                                                            1]
                                                    .members >=
                                                snapshot
                                                    .data![
                                                        snapshot.data!.length -
                                                            index -
                                                            1]
                                                    .max
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      snapshot
                                                          .data![snapshot.data!
                                                                  .length -
                                                              index -
                                                              1]
                                                          .content,
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                        const Expanded(
                                          child: SizedBox(),
                                        ),
                                        Text(
                                          snapshot
                                              .data![snapshot.data!.length -
                                                  index -
                                                  1]
                                              .place,
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          snapshot
                                              .data![snapshot.data!.length -
                                                  index -
                                                  1]
                                              .date,
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                        Text(
                                          '신청 / 최대인원 : ${snapshot.data![snapshot.data!.length - index - 1].members} / ${snapshot.data![snapshot.data!.length - index - 1].max}',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No data');
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
              const LogOut(),
            ],
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // 뒤로가기 버튼을 무시하고 아무 동작도 하지 않음
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 2,
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
          title: const Center(
            child: Text(
              "S E N A",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        body: body,
      ),
    );
  }
}
