import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:ajousenior/data/post.dart';

class CommunityProviders {
  final uri = Uri.parse("http://54.180.8.70:4000/community/readall");

  Future<List<Post>> getPost() async {
    List<Post> entries = [];
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      for (var posts in responseJson['data']) {
        entries.add(Post.fromJson(posts));
      }
      return entries;
    } else {
      throw Exception('Failed to load post');
    }
  }
}
