import './userdata_model.dart';
import 'package:http/http.dart' show Client;

class ApiService {
  final String baseUrl = "http://35.198.233.87:8080";
  Client http = Client();

  Future<bool> deleteProfile(int id) async {
    final response = await http.delete(
      "$baseUrl/profile/delete/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createProfile(UserData data) async {
    final response = await http.post(
      "$baseUrl/create",
      headers: {"content-type": "application/json"},
      body: profileToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

}