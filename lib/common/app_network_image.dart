import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppNetworkImage extends StatelessWidget {
  final Uri? uri;
  final double width;
  final double height;
  final double radius;
  const AppNetworkImage({
    this.uri,
    this.width = 198,
    this.height = 136,
    this.radius = 8,
    Key? key,
  }) : super(key: key);

  Widget _noImage() {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
      child: Container(
        width: width,
        height: height,
        color: AppColors.secondary_90,
        child: Icon(Icons.home_work, color: AppColors.secondary_70),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (uri == null) {
      return _noImage();
    }
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        child: CachedNetworkImage(
            imageUrl: uri.toString(),
            imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
            errorWidget: (context, url, error) {
              return _noImage();
            }),
      ),
    );
  }
}
