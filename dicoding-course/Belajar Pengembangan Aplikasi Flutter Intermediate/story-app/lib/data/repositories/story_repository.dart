import 'dart:typed_data';

import 'package:storyapp/data/repositories/preferences_helper.dart';
import 'package:storyapp/model/response_default.dart';
import 'package:storyapp/model/stories.dart';
import 'package:storyapp/model/upload_story.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

class StoryRepositories {
  static const String _baseUrl = "https://story-api.dicoding.dev/v1";
  final PreferencesHelper preferencesHelper;

  StoryRepositories({required this.preferencesHelper});

  Future<ResponseDefault> createStory(UploadStory uploadStory) async {
    final loginResult = await preferencesHelper.loginResult;
    if (loginResult == null) return ResponseDefault(error: true, message: "Please Login First");
    final token = loginResult.token;

    final uri = Uri.parse("$_baseUrl/stories");
    final request = http.MultipartRequest('POST', uri);

    final newBytes = await compressImage(uploadStory.bytes);

    final multiPartFile = http.MultipartFile.fromBytes("photo", newBytes, filename: uploadStory.fileName);
    final Map<String, String> fields = {"description": uploadStory.description};
    final Map<String, String> headers = {"Content-Type": "multipart/form-data", "Authorization": "Bearer $token"};

    request.files.add(multiPartFile);
    request.fields.addAll(fields);
    request.headers.addAll(headers);

    try {
      final http.StreamedResponse streamedResponse = await request.send();
      final Uint8List responseList = await streamedResponse.stream.toBytes();
      final String responseData = String.fromCharCodes(responseList);
      return ResponseDefault.fromRawJson(responseData);
    } catch (e) {
      throw Exception('Server Error $e');
    }
  }

  Future<Stories> getStories({int? page, int? size, int? location = 0}) async {
    final loginResult = await preferencesHelper.loginResult;
    if (loginResult == null) return Stories(error: true, message: "Please Login First", listStory: []);
    final token = loginResult.token;

    String uriString = "$_baseUrl/stories?";
    if (location != null) uriString += "location=$location";
    if (page != null) uriString += "&page=$page";
    if (size != null) uriString += "&size=$size";
    final uri = Uri.parse(uriString);

    try {
      final request = await http.get(uri, headers: {"Authorization": "Bearer $token"});
      return Stories.fromRawJson(request.body);
    } catch (e) {
      throw Exception('Server Error $e');
    }
  }

  Future<List<int>> compressImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;
    final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];
    do {
      ///
      compressQuality -= 10;
      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );
      length = newByte.length;
    } while (length > 1000000);
    return newByte;
  }
}
