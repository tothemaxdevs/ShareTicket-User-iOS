import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/widget/shimmer/shimmer.dart';

class CircleAvatars extends StatelessWidget {
  double? size;
  String? imageUrl;
  CircleAvatars({
    required this.imageUrl,
    this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(Dimens.size112)),
      child: CachedNetworkImage(
        imageUrl: '$imageUrl',
        fit: BoxFit.cover,
        width: size ?? Dimens.size32,
        height: size ?? Dimens.size32,
        placeholder: (context, url) => Blink(
          height: size ?? Dimens.size32,
          width: size ?? Dimens.size32,
          isCircle: true,
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/images/pngs/ic_profile_blank.png',
          height: size ?? Dimens.size32,
          width: size ?? Dimens.size32,
        ),
      ),
    );
  }
}
