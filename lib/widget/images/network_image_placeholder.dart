import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shareticket/config/colors/pallete.config.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/widget/shimmer/shimmer.dart';

class NetworkImagePlaceHolder extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool? click;
  final BorderRadius? borderRadius;
  final bool isRounded;
  final bool isCircle;

  NetworkImagePlaceHolder(
      {required this.imageUrl,
      this.width,
      this.height,
      this.fit,
      this.click = false,
      this.borderRadius,
      this.isRounded = false,
      this.isCircle = false});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ??
          (isRounded
              ? const BorderRadius.all(Radius.circular(Dimens.size12))
              : (isCircle
                  ? const BorderRadius.all(Radius.circular(300))
                  : BorderRadius.zero)),
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: fit ?? BoxFit.cover,
        width: width ?? null,
        height: height ?? null,
        placeholder: (context, url) =>
            // Blink(height: height ?? null!, width: width ?? null!),
            const SpinKitCircle(
          color: Pallete.primary,
          size: 20,
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/images/pngs/ic_image_blank.png',
          fit: fit ?? BoxFit.cover,
          width: width ?? null,
          height: height ?? null,
        ),
      ),
    );
  }
}
