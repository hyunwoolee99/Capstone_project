import 'dart:convert';
import 'package:http/http.dart' as http;

class GetVolListService {
  var url = Uri.parse("http://54.180.8.70:4000/talentdonation/readall");
  getVolList() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      print(res['data']);
      return res['data'];
    } else {
      throw Exception('fail');
    }
  }
}
