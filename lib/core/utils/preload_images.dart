import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PreLoadImage {
  static Future<Image> loadImg(BuildContext context, String path) async {
    var image = Image.asset(path);
    await precacheImage(image.image, context);
    return image;
  }

  static Future precacheSvgPicture(String svgPath) async {
    final logo = SvgAssetLoader(svgPath);
    await svg.cache.putIfAbsent(
      logo.cacheKey(null),
      () => logo.loadBytes(null),
    );
  }
}
