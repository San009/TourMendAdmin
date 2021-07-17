import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

class FormService {
  static Future<String> addPlace(String name, String destination, String info,
      String itinerary, File placeImage, File map) async {
    try {
      final uri =
          Uri.parse("http://10.0.2.2/TourMendWebServices/addPlaces.php");

      var request = http.MultipartRequest('POST', uri);
      var pic = await http.MultipartFile.fromPath("image", placeImage.path);
      var pic2 = await http.MultipartFile.fromPath("map", map.path);
      request.files.add(pic);
      request.files.add(pic2);
      request.fields['Pname'] = name;
      request.fields['destination'] = destination;
      request.fields['info'] = info;
      request.fields['itinerary'] = itinerary;
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
  static Future<String> editPlace(String id, String name, String destination,
      String info, String itinerary, File placeImage, File map) async {
    try {
      final uri =
          Uri.parse("http://10.0.2.2/TourMendWebServices/addPlaces.php");

      var request = http.MultipartRequest('POST', uri);
      var pic = await http.MultipartFile.fromPath("image", placeImage.path);
      var pic2 = await http.MultipartFile.fromPath("map", map.path);
      request.files.add(pic);
      request.files.add(pic2);
      request.fields['id'] = id;
      request.fields['Pname'] = name;
      request.fields['destination'] = destination;
      request.fields['info'] = info;
      request.fields['itinerary'] = itinerary;
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
}
