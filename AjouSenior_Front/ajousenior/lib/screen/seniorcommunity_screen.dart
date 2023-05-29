import 'package:ajousenior/data/post.dart';
import 'package:ajousenior/provider/communityprovider.dart';
import 'package:ajousenior/screen/community_post_screen.dart';
import 'package:ajousenior/screen/community_content_screen.dart';
import 'package:ajousenior/screen/senior_screen.dart';
import 'package:flutter/material.dart';
//import 'dart:async';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});
  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  /*Future initPosts() async {
    entries = await CommunityProviders().getPost();
  }*/
  final List<Color> colorList = [
    const Color.fromARGB(147, 94, 222, 102),
    const Color.fromARGB(200, 76, 181, 222),
    const Color.fromARGB(176, 218, 113, 113),
    const Color.fromARGB(255, 200, 255, 0),
    const Color.fromARGB(200, 174, 124, 207),
  ];

  @override
  void initState() {
    super.initState();
    /*initPosts().then((_) {
      setState(() {
        isLoading = false;
      });
    });*/
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
        body: FutureBuilder<List<Post>>(
          future: CommunityProviders().getPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContentScreen(
                              current: snapshot
                                  .data![snapshot.data!.length - index - 1]),
                        ),
                      ).then((value) {});
                    },
                    title: Container(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      height: 120,
                      width: double.maxFinite,
                      child: Card(
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                width: 9.0,
                                color: colorList[index % colorList.length],
                              ),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(7),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot
                                      .data![snapshot.data!.length - index - 1]
                                      .title,
                                  style: const TextStyle(
                                    fontSize: 30,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Expanded(child: SizedBox()),
                                Text(
                                  '${snapshot.data![snapshot.data!.length - index - 1].date} / ${snapshot.data![snapshot.data!.length - index - 1].userID}',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                  ),
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
              return Text("${snapshot.error}");
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PostScreen(),
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
