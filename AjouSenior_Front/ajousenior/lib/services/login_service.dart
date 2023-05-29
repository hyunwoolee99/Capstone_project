import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  static sendLogin(String? pro, acc, gen, age, cen, bir) async {
    var url = Uri.http("54.180.8.70:4000", "/user/signup");
    var res = await http.post(
      url,
      body: {
        "profile_nickname": pro,
        "account_email": acc,
        "gender": gen,
        "age_range": age,
        "seniorcenter": cen,
        "birthday": bir
      },
    );

    if (res.statusCode == 200) {
      var msg = jsonDecode((res.body));
      print(msg);
      return msg['data']['_id'];
    } else {
      print(res.body);
      throw (e) {
        print(e);
      };
    }
  }
}
