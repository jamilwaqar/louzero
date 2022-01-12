import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppAvatar extends StatelessWidget {
  final Uri? url;
  final String? text;
  final Color? borderColor;
  final Color? backgroundColor;
  final double size;
  final String? placeHolder;

  const AppAvatar(
      {Key? key,
      this.url,
      this.borderColor,
      this.backgroundColor,
      this.text = '',
      this.placeHolder,
      this.size = 96})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      padding: borderColor == null
          ? const EdgeInsets.all(0)
          : const EdgeInsets.all(2),
      decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(999),
          color: backgroundColor ?? Colors.transparent),
      child: Text(
        text!.isNotEmpty ? text! : 'ME',
        style: AppStyles.headerRegular
            .copyWith(color: AppColors.secondary_99, fontSize: size * .50),
      ),
      // child: url == null
      //     ? placeHolder != null
      //         ? AppImage(
      //             placeHolder!,
      //             width: size,
      //             height: size,
      //           )
      //         : _initials()
      //     : _cachedNetworkImage(),
    );
  }

  Widget _cachedNetworkImage() => CachedNetworkImage(
      imageUrl: url.toString(),
      imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
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
        return Container();
      });

  Widget _initials() => Text(
        text!,
        style: TextStyle(
          color: AppColors.lightest,
          fontWeight: FontWeight.w500,
          fontSize: size / 2.2,
        ),
      );
}
