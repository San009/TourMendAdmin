import 'dart:convert';
import '../../modals/profileModal/userInfoList.dart';
import '../../modals/profileModal/userInfo.dart';

import 'package:http/http.dart' as http;

class FetchUsers {
  static Future<UserInfoList> fetchUsers({int pageNumber}) async {
    final List<UserInfo> users = [];
    try {
      final url =
          "http://10.0.2.2/TourMendWebServices/userList.php?page_number=" +
              pageNumber.toString();
      final response = await http.get(url);

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (respJson['users'] != null) {
          for (var user in respJson['users']) {
            var eventData = UserInfo(
              id: user['id'],
              userEmail: user['userEmail'],
              userName: user['userName'],
              userImage: user['userImage'],
              status: user['status'],
            );

            users.add(eventData);
          }
          return UserInfoList(
            users: users,
            message: respJson['message'],
            statusCode: respJson['statusCode'],
          );
        } else
          return UserInfoList(
              users: null,
              message: respJson['message'],
              statusCode: respJson['statusCode']);
      } else {
        return UserInfoList(
            users: null,
            message: respJson['message'],
            statusCode: respJson['statusCode']);
      }
    } catch (e) {
      return UserInfoList(
        users: null,
        message: "Exception: " + e.toString(),
        statusCode: 'Error',
      );
    }
  }

  static Future<String> deleteUsers(String id) async {
    try {
      const url = "http://10.0.2.2/TourMendWebServices/deleteUsers.php";
      //post data into the url
      final response = await http.post(url, body: {"id": id});

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(respJson['statusCode']);
        return respJson['statusCode'];
      } else {
        return 'Registering failed due to server error!';
      }
    } catch (e) {
      return "Error!" + e.toString();
    }
  }

  static Future<String> activeUsers(String id, String status) async {
    try {
      const url = "http://10.0.2.2/TourMendWebServices/activeUsers.php";
      //post data into the url
      final response = await http.post(url, body: {"id": id, "status": status});

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(respJson['statusCode']);
        return respJson['statusCode'];
      } else {
        return 'Registering failed due to server error!';
      }
    } catch (e) {
      return "Error!" + e.toString();
    }
  }
}
