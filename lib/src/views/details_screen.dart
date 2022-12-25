import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallify/src/controllers/wallpaper_controller.dart';
import 'package:wallify/src/models/wallpaper_model.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.wallpaper}) : super(key: key);
  final WallpaperModel wallpaper;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WallpaperController>(
        init: WallpaperController(),
        builder: (controller) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: wallpaper.thumbnail,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    progressIndicatorBuilder: (context, url, progress) =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.downloadWallpaper(wallpaper.original);
                      },
                      icon: const Icon(Icons.download),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        });
  }
}
