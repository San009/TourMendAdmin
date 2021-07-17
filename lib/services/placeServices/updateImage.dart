import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class ImageService {
  // ignore: missing_return
  static Future<String> updatePI(String id, File placeImage) async {
    try {
      final uri =
          Uri.parse("http://10.0.2.2/TourMendWebServices/uploadImagePI.php");

      var request = http.MultipartRequest('POST', uri);
      var pic =
          await http.MultipartFile.fromPath("placeimage", placeImage.path);

      request.files.add(pic);

      request.fields['id'] = id;

      print(pic);
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Image Uploaded');
      } else {
        print('Image not Uploaded');
        return 'Upload failed due to server error!';
      }
    } catch (e) {
      return ('Error in live(): ' + e.toString());
    }
  }

  // ignore: missing_return
  static Future<String> updateMI(String id, File mapImage) async {
    try {
      final uri =
          Uri.parse("http://10.0.2.2/TourMendWebServices/uploadImageMI.php");

      var request = http.MultipartRequest('POST', uri);
      var pic1 = await http.MultipartFile.fromPath("image", mapImage.path);

      request.files.add(pic1);

      request.fields['id'] = id;

      print(pic1);
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Image Uploaded');
      } else {
        print('Image not Uploaded');
        return 'Upload failed due to server error!';
      }
    } catch (e) {
      return ('Error in live(): ' + e.toString());
    }
  }
}
