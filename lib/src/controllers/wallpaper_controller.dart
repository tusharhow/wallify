import 'dart:io';
import 'package:get/get.dart';
import 'package:wallify/src/services/api_service.dart';
import '../models/wallpaper_model.dart';

class WallpaperController extends GetxController {
  final ApiService apiService = ApiService();
  var wallpapers = <WallpaperModel>[].obs;
  var isLoading = true.obs;

  Future<List<WallpaperModel>> fetchWallpaper(String query) async {
    isLoading(true);
    update();
    wallpapers.addAll(await apiService.getWallpapers(query));
    isLoading(false);
    update();
    return wallpapers;
  }

  var isDownloading = false.obs;
  Future<File?> downloadWallpaper(String url) async {
    return await apiService.downloadWallpaper(url);
  }

  @override
  void onInit() {
    wallpapers.isEmpty ? fetchWallpaper('nature') : null;
    super.onInit();
  }
}
