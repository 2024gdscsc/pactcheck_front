import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;

Future<void> uploadImage(List<String> filePaths) async {
  final dio = Dio();

  FormData formData = FormData();

  for (String filePath in filePaths) {
    String fileName = path.basename(filePath);
    formData.files.add(MapEntry(
      "images",
      await MultipartFile.fromFile(filePath, filename: fileName),
    ));
  }

  try {
    Response response = await dio.post('~', data: formData);
    if (response.statusCode != 201) {
      throw Exception('Failed');
    }
  } catch (e) {
    throw e;
  }
}
