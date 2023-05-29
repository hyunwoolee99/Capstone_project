import 'dart:convert';
import 'package:http/http.dart' as http;

class JuniorVolunList {
  static Future<List<Map<String, dynamic>>> juniorVolunlist(
      String? userId) async {
    print("${userId!}를 읽어왔습니다");
    var url = Uri.http("54.180.8.70:4000", "/junior/findtalentdonationhope");
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

  static Future<List<Map<String, dynamic>>> lastjuniorVolunlist(
      String? userId) async {
    print("${userId!}를 읽어왔습니다");
    var url =
        Uri.http("54.180.8.70:4000", "/junior/confirmfindtalentdonationhope");
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
