import 'package:http/http.dart' as http;
import 'dart:convert';

class GetAll {
  static Future<String> getUsers() async {
    try {
      final url = "http://10.0.2.2/TourMendWebServices/countUsers.php";
      var response = await http.get(Uri.encodeFull(url));

      var respJson = json.decode(response.body);

      if (response.statusCode == 200) {
        print(respJson['message']);
        return respJson['users'];
      } else {
        print(respJson['message']);
        return null;
      }
    } catch (e) {
      print('Error in getUserInfo(): ' + e.toString());
      return null;
    }
  }

  static Future<String> getAdmin() async {
    try {
      final url = "http://10.0.2.2/TourMendWebServices/countUsers.php";
      var response = await http.get(Uri.encodeFull(url));

      var respJson = json.decode(response.body);

      if (response.statusCode == 200) {
        print(respJson['message']);
        return respJson['admin'];
      } else {
        print(respJson['message']);
        return null;
      }
    } catch (e) {
      print('Error in getUserImage(): ' + e.toString());
      return null;
    }
  }
}
