import 'dart:convert';
import '../../modals/profileModal/adminInfoList.dart';
import '../../modals/profileModal/adminInfo.dart';

import 'package:http/http.dart' as http;

class FetchUsers {
  static Future<AdminInfoList> fetchUsers({int pageNumber}) async {
    final List<AdminInfo> admins = [];
    try {
      final url =
          "http://10.0.2.2/TourMendWebServices/adminList.php?page_number=" +
              pageNumber.toString();
      final response = await http.get(url);

      final respJson = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (respJson['admins'] != null) {
          for (var admin in respJson['admins']) {
            var eventData = AdminInfo(
              adminEmail: admin['adminEmail'],
              adminName: admin['adminName'],
              adminImage: admin['adminImage'],
            );

            admins.add(eventData);
          }
          return AdminInfoList(
            admins: admins,
            message: respJson['message'],
            statusCode: respJson['statusCode'],
          );
        } else
          return AdminInfoList(
              admins: null,
              message: respJson['message'],
              statusCode: respJson['statusCode']);
      } else {
        return AdminInfoList(
            admins: null,
            message: respJson['message'],
            statusCode: respJson['statusCode']);
      }
    } catch (e) {
      return AdminInfoList(
        admins: null,
        message: "Exception: " + e.toString(),
        statusCode: 'Error',
      );
    }
  }
}
