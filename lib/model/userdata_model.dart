import 'dart:convert';
import 'package:http/http.dart' as http;

class UserData{
  int id;
  String firstname;
  String lastname;

  UserData({this.id = 0, this.firstname, this.lastname});


  factory UserData.fromJson(Map<String, dynamic> map) {
    return UserData(
        id: map["id"], firstname: map["firstname"], lastname: map["lastname"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "firstname": firstname, "lastname": lastname};
  }

  @override
  String toString() {
    return 'Profile{id: $id, firstname: $firstname, lastname: $lastname}';
  }

  List<UserData> profileFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<UserData>.from(data.map((item) => UserData.fromJson(item)));
  }

  String profileToJson(UserData data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
  }

  Future<bool> updateProfile(UserData data) async {
  final response = await http.put(
    "http://35.198.233.87:8080/profile/${data.id}",
    headers: {"content-type": "application/json"},
    body: profileToJson(data),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

}