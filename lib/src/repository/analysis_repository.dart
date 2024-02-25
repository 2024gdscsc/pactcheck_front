// import 'dart:convert';
// import 'dart:io';
//
// import 'package:dio/dio.dart';
//
// Future<void> sendImages(List<String> imagePaths) async {
//
//   final dio = Dio();
//   List<String> base64Images = [];
//
//   for (String path in imagePaths) {
//     File imageFile = File(path);
//     String base64Image = base64Encode(await imageFile.readAsBytes());
//     base64Images.add(base64Image);
//   }
// print(base64Images);
//   try {
//     final response = await dio.put(
//       'http://localhost:3000/api/v0/ana/contract',
//       data: {
//         "images": base64Images,
//       },
//     );
//
//     if (response.statusCode == 200) {
//       print('Response received: ${response.data}');
//     } else {
//       print('Failed to upload images. Status code: ${response.statusCode}');
//     }
//   } on DioError catch (e) {
//     print('DioError caught: ${e.message}');
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> sendImages(List<String> imagePaths) async {
  List<String> base64Images = [];

  for (String path in imagePaths) {
    File imageFile = File(path);
    String base64Image = base64Encode(await imageFile.readAsBytes());
    base64Images.add(base64Image);
  }

  print(base64Images);

  try {
    final response = await http.put(
      Uri.parse('http://10.0.2.2:3000/api/v0/ana/contract'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        "images": base64Images,
      }),
    );

    if (response.statusCode == 200) {
      print('Response received: ${response.body}');
      return json.decode(response.body);
    } else {
      print('Failed to upload images. Status code: ${response.statusCode}');
      throw Exception('Failed to upload images');
    }
  } catch (e) {
    print('Error caught: $e');
    throw Exception('Error sending images: $e');
  }
}
