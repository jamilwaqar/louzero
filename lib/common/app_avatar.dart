import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'app_image.dart';

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
      child: url == null
          ? placeHolder != null
              ? AppImage(
                  placeHolder!,
                  width: size,
                  height: size,
                )
              : _initials()
          : _cachedNetworkImage(),
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
      placeholder: (context, url) => Center(
            child: Container(
              width: size / 2,
              height: size / 2,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          ),
      errorWidget: (context, url, error) {
        return Container();
      });

  Widget _initials() => Text(
        text?.isNotEmpty ?? false ? text! : 'ME',
        style: TextStyle(
          color: AppColors.lightest,
          fontWeight: FontWeight.w500,
          fontSize: size / 2.2,
        ),
      );
}
