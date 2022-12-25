import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallify/src/constants/api_constant.dart';
import '../models/wallpaper_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<WallpaperModel>> getWallpapers(String query) async {
    query = query.replaceAll(' ', '+');
    final response = await _dio.get(
      'https://api.pexels.com/v1/search?query=$query&per_page=50',
      options: Options(
        headers: {'Authorization': apiKey},
      ),
    );
    if (response.statusCode == 200) {
      final List<WallpaperModel> wallpapers = [];
      final data = jsonDecode(response.toString());
      data['photos'].forEach((element) {
        wallpapers.add(WallpaperModel.fromJson(element['src']));
      });

      return wallpapers;
    } else {
      throw Exception(
          'Failed to load wallpapers. Status code: ${response.statusCode}');
    }
  }

  Future<File?> downloadWallpaper(String url) async {
    try {
      Directory dir = await getTemporaryDirectory();
      var response = await _dio.get(url,
          options: Options(responseType: ResponseType.bytes));
      var filePath = '${dir.path}/${DateTime.now().toIso8601String()}.jpg';
      File file = File(filePath);
      file.writeAsBytesSync(response.data);
      return file;
    } catch (e) {
      return null;
    }
  }
}
