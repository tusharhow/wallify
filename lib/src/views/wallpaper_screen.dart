import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallify/src/controllers/wallpaper_controller.dart';
import 'details_screen.dart';


class WallpaperScreen extends StatelessWidget {
  const WallpaperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WallpaperController>(
        init: WallpaperController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Wallify'),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.black54),
                      prefixIcon: Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      filled: true,
                      fillColor: Colors.black12,
                    ),
                    onFieldSubmitted: (value) {
                      controller.fetchWallpaper(value);
                      controller.update();
                    },
                    onChanged: (value) {
                      controller.fetchWallpaper(value);
                      controller.update();
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.wallpapers.length,
                            itemBuilder: (context, index) {
                              final wallpaper = controller.wallpapers[index];
                              return CachedNetworkImage(
                                imageUrl: wallpaper.thumbnail,
                                imageBuilder: (context, imageProvider) =>
                                    GestureDetector(
                                  onTap: () {
                                    Get.to(() =>
                                        DetailsScreen(wallpaper: wallpaper));

                             
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
          );
        });
  }
}
