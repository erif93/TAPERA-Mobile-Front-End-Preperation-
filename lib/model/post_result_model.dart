import 'package:http/http.dart' as http;
import 'dart:convert';

class PostResult {
  String message;
  String sessionId;
  String sessionUser;
  String status;

  PostResult({this.message, this.sessionId, this.sessionUser, this.status});
  
  factory PostResult.createPostResult(Map<String, dynamic> object){
    return PostResult(
      message: object['message'],
      sessionId: object['sessionId'],
      sessionUser: object['sessionUser'],
      status: object['status']
    );
  }
  static Future<PostResult> connectToAPI(String username, password) async
  {
    String credentials = username+':'+password;
    Codec<String, String> stringaToBase64 = utf8.fuse(base64);
    String encoded = 'Basic ' + stringaToBase64.encode(credentials);
    print(encoded);

     String url = 'http://35.198.233.87:8080/login'; 
    // String url = 'https://reqres.in/api/users'; 
    var result = await http.post(url, headers: {'Authorization':encoded});
    var jsonObject = json.decode(result.body);
    return PostResult.createPostResult(jsonObject);
  }
}