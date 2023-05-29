import 'dart:convert';
import 'package:http/http.dart' as http;

/*
class FindCenterService {
  static sendCenter(String? message) async {
    var url = Uri.https("54.180.8.70:4000", "/seniorcenter/findseniorcenter");
    var res = await http.post(
      url,
      body: jsonEncode({"findname": "주공"}),
    );

    if (res.statusCode == 200) {
      Map<String, dynamic> msg = jsonDecode((res.body));
      return msg;
    } else {
      print(res.body);
      throw (e) {
        print(e);
      };
    }
  }
}
*/
class FindCenterService {
  static findCenter(String query) async {
    var url =
        Uri.parse("http://54.180.8.70:4000/seniorcenter/findseniorcenter");
    final response = await http.post(
      url,
      body: {"findname": query},
    );

    if (response.statusCode == 200) {
      // 서버에서 반환한 데이터를 JSON 형식으로 파싱합니다.
      print(response.body);
      print(response.statusCode);
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      print(data);
      // 검색 결과 데이터를 반환합니다.
      return data;
    } else {
      print(response.statusCode);
      print(response.body);
      // 요청이 실패한 경우 예외를 발생시킵니다.
      throw Exception('Failed to search.');
    }
  }
}
