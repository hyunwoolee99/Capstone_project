import 'package:http/http.dart' as http;
import 'dart:convert';

class SeniorLastVol {
  static Future<List<Map<String, dynamic>>> seniorLastVol(
      String? userId) async {
    print("${userId!}를 읽어왔습니다");
    var url = Uri.http("54.180.8.70:4000", "/senior/mylastdatedonation");
    var res = await http.post(
      url,
      body: {
        "userId": userId,
      },
    );

    if (res.statusCode == 200) {
      var msg = jsonDecode((res.body));
      var dataList = msg['data'];
      print(200);
      print(dataList);
      var resultList = <Map<String, dynamic>>[];
      for (var data in dataList) {
        resultList.addAll(List<Map<String, dynamic>>.from(data));
      }
      return resultList;
    } else {
      print(res.body);
      throw (e) {
        print(e);
      };
    }
  }
}
