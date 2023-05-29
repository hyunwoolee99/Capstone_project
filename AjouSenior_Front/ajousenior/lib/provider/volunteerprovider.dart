import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:ajousenior/models/senior_model.dart';
import 'package:ajousenior/data/volunteer_post.dart';

class VolunteerProviders {
  final uri = Uri.parse("http://54.180.8.70:4000/talentdonation/readall");
  Future<List<VolunteerPost>> getPost() async {
    List<VolunteerPost> entries = [];
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      for (var posts in responseJson['data']) {
        entries.add(VolunteerPost.fromJson(posts));
        print(posts);
      }
      //print(entries[0].members);
      return entries;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<List<VolunteerPost>> getlastPost(String? username) async {
    var url = Uri.http("54.180.8.70:4000", "/senior/mylastdatedonation");
    List<VolunteerPost> entries = [];
    var data = {"username": username};
    var body = json.encode(data);
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      for (var posts in responseJson['data']) {
        entries.add(VolunteerPost.fromJson(posts));
        print(posts);
      }
      return entries;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<List<VolunteerPost>> getmyPost(String? username) async {
    var url = Uri.http("54.180.8.70:4000", "/senior/mytalentdonation");
    List<VolunteerPost> entries = [];
    var data = {"username": username};
    var body = json.encode(data);
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      for (var posts in responseJson['data']) {
        entries.add(VolunteerPost.fromJson(posts));
      }
      return entries;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<List<Senior>> getList(String donationID) async {
    final url =
        Uri.parse("http://54.180.8.70:4000/senior/findtalentdonationhope");
    List<Senior> entries = [];
    var data = {"donationid": donationID};
    var body = json.encode(data);
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      for (var users in responseJson['data']) {
        entries.add(Senior.fromJson(users[0]));
      }
      return entries;
    } else {
      throw Exception('Failed to load list');
    }
  }
}
