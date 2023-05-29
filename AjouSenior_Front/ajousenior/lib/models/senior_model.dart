class Senior {
  //닉네임,이메일,성별,나이,센터,생일//
  String? profile_nickname;
  String? account_email;
  String? gender;
  String? age_range;
  String? seniorcenter;
  String? birthday;
  String? id;
  Senior(this.profile_nickname, this.account_email, this.gender, this.age_range,
      this.seniorcenter, this.birthday, this.id);
  String split = "//";
  factory Senior.fromJson(Map<String, dynamic>? map) {
    return Senior(
      map?['profile_nickname'] ?? '',
      map?['account_email'] ?? '',
      map?['gender'] ?? '',
      map?['age_range'] ?? 30,
      map?['seniorcenter'] ?? 0,
      map?['birthday'] ?? '',
      map?['_id'] ?? '',
    );
  }
  @override
  String toString() {
    // TODO: implement toString
    return profile_nickname! +
        split +
        account_email! +
        split +
        gender! +
        split +
        age_range! +
        split +
        seniorcenter! +
        split +
        birthday! +
        split +
        id!;
  }
}

Senior StringTo(String a) {
  List<String> result = a.split('//');
  return Senior(result[0], result[1], result[2], result[3], result[4],
      result[5], result[6]);
}

Future<Senior> StringTo2(String a) async {
  List<String> result = a.split('//');
  return Senior(
    result[0],
    result[1],
    result[2],
    result[3],
    result[4],
    result[5],
    result[6],
  );
}
