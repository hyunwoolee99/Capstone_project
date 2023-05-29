import 'package:intl/intl.dart';

class VolunteerPost {
  //final String title;
  final String place;
  final String date;
  final String userID;
  final String content;
  final int max;
  final String donationid;
  int members = 0;

  VolunteerPost({
    //required this.title,
    required this.place,
    required this.date,
    required this.userID,
    required this.content,
    required this.max,
    required this.donationid,
    required this.members, //for test
  });
  factory VolunteerPost.fromJson(Map<String, dynamic>? map) {
    return VolunteerPost(
      place: map?['seniorcenter'] ?? '',
      content: map?['content'] ?? '',
      userID: map?['writer'] ?? '',
      date: DateFormat.yMMMd().format(DateTime.parse(map?['date'] ?? '')),
      max: map?['maxpeople'] ?? 30,
      members: map?['currentpeople'] ?? 0,
      donationid: map?['_id'] ?? '',
    );
  }
}
