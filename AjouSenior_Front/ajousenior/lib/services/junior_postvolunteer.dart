import 'dart:convert';
import 'package:http/http.dart' as http;

class JuniorPostVolunteer {
  static sendVolunteer(
      String donationId, String? userId, String? currentPeople) async {
    var url = Uri.http("54.180.8.70:4000", "/talentdonation/hope");

    var res = await http.post(url, body: {
      "donationid": donationId,
      "userid": userId,
      "currentpeople": currentPeople,
    });

    if (res.statusCode == 200) {
      var msg = jsonDecode((res.body));
      print(msg);
      return msg;
    } else {
      print(res.body);
      throw (e) {
        print(e);
      };
    }
  }
}
