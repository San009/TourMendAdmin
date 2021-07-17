import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class AddService {
  static Future<String> addUser(
    String userEmail,
    String userName,
    String password,
  ) async {
    try {
      const url = "http://10.0.2.2/TourMendWebServices/addUser.php";
      final response = await http.post(url, body: {
        "userEmail": userEmail,
        "userName": userName,
        "password": password,
      });

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(respJson['message']);
        return respJson['statusCode'];
      } else {
        return 'Error while submitting event!';
      }
    } catch (e) {
      return ('Error in live(): ' + e.toString());
    }
  }

  static Future<String> editUser(
    String id,
    String userEmail,
    String userName,
    String password,
  ) async {
    try {
      const url = "http://10.0.2.2/TourMendWebServices/editUsers.php";
      final response = await http.post(url, body: {
        "id": id,
        "userEmail": userEmail,
        "userName": userName,
        "password": password,
      });

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(respJson['message']);
        return respJson['statusCode'];
      } else {
        return 'Error while submitting event!';
      }
    } catch (e) {
      return ('Error in live(): ' + e.toString());
    }
  }
}
