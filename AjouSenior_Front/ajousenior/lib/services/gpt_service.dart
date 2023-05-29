import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String? apiKey = dotenv.env['ApiKey'];

class GptService {
  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey'
  };

  static sendMessage(String? message) async {
    var url = Uri.https("api.openai.com", "/v1/completions");
    var res = await http.post(
      url,
      headers: header,
      body: jsonEncode({
        "model": "text-davinci-003",
        "prompt": message,
        "max_tokens": 200,
        "temperature": 0.8
      }),
    );

    if (res.statusCode == 200) {
      Map<String, dynamic> msg = jsonDecode(utf8.decode(res.bodyBytes));
      msg['choices'][0]['text'];
      return msg['choices'][0]['text'];
    } else {
      print(res.body);
    }
  }
}
