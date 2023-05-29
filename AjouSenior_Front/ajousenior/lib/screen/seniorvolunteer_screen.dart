import 'package:ajousenior/data/volunteer_post.dart';
import 'package:ajousenior/screen/senior_screen.dart';
import 'package:ajousenior/screen/seniorvolunteer_myscreen.dart';
import 'package:ajousenior/screen/volunteer_content_screen.dart';
import 'package:ajousenior/screen/volunteer_post_screen.dart';
import 'package:ajousenior/widgets/volunteer_onrecruit_widget.dart';
import 'package:ajousenior/provider/volunteerprovider.dart';
import 'package:ajousenior/models/senior_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

class SeniorVolunteerScreen extends StatefulWidget {
  const SeniorVolunteerScreen({super.key});
  @override
  State<SeniorVolunteerScreen> createState() => _SeniorVolunteerScreenState();
}

class _SeniorVolunteerScreenState extends State<SeniorVolunteerScreen> {
  static var storage = const FlutterSecureStorage();
  dynamic userInfo = '';
  late Senior user;
  @override
  void initState() {
    super.initState();
    // 비동기로 flutter secure storage 정보를 불러오는 작업
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
/*      if (userInfo != '') {
        user = StringTo(userInfo);
      }*/
    });
  }

  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    userInfo = await storage.read(key: 'login');
    user = StringTo(userInfo);
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
                        builder: (context) => const SeniorScreen()));
              },
            ),
            title: const Text('           전체 재능 기부'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.green,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {
                  // 아이콘 버튼 실행
                },
              ),
              IconButton(
                icon: const Icon(Icons.person_outline), // 검색 아이콘 생성
                onPressed: () {
                  // 아이콘 버튼 실행
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeniorMyScreen(
                        user: user,
                      ),
                    ),
                  );
                },
              ),
            ]),
        body: FutureBuilder<List<VolunteerPost>>(
          future: VolunteerProviders().getPost(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No data');
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VolunteerContentScreen(
                              current: snapshot
                                  .data![snapshot.data!.length - index - 1]),
                        ),
                      ).then((value) {});
                    },
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
                                            .data![snapshot.data!.length -
                                                index -
                                                1]
                                            .members >=
                                        snapshot
                                            .data![snapshot.data!.length -
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              snapshot
                                                  .data![snapshot.data!.length -
                                                      index -
                                                      1]
                                                  .content,
                                              style: const TextStyle(
                                                fontSize: 20,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    OnRecruit(
                                      full: snapshot
                                              .data![snapshot.data!.length -
                                                  index -
                                                  1]
                                              .members >=
                                          snapshot
                                              .data![snapshot.data!.length -
                                                  index -
                                                  1]
                                              .max,
                                    ),
                                  ],
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                Text(
                                  snapshot
                                      .data![snapshot.data!.length - index - 1]
                                      .place,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  // DateConverter.convertToKorean(snapshot
                                  //     .data![snapshot.data!.length - index - 1]
                                  //     .date)
                                  snapshot
                                      .data![snapshot.data!.length - index - 1]
                                      .date,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
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
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const VolunteerPostScreen(),
              ),
            ).then((value) {
              setState(() {});
            });
          },
          tooltip: 'Post',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
