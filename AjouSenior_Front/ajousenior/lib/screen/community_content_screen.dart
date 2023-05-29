import 'package:ajousenior/data/post.dart';
import 'package:flutter/material.dart';

class ContentScreen extends StatelessWidget {
  final Post current;
  const ContentScreen({
    super.key,
    required this.current,
  });

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
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              current.title,
              style: const TextStyle(
                fontSize: 32,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '${current.date} / ${current.userID}',
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              current.content,
            ),
            const SizedBox(
              height: 50,
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: 'comment',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("comment"),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            /*ListView.separated(
              itemCount: current.comments.length,
              itemBuilder: (BuildContext context, int index) {
                if (current.comments.isNotEmpty) {
                  return ListTile(
                    title: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      height: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            current.comments[index].userID,
                          ),
                          Text(
                            current.comments[index].comment,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return null;
                }
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),*/
          ],
        ),
      ),
    );
  }
}
