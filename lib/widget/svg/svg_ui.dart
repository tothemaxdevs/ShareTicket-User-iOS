import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgUI extends StatelessWidget {
  const SvgUI(
    this.svgSource, {
    Key? key,
    this.onTap,
    this.width,
    this.height,
    this.padding,
    this.color,
    this.fit,
  }) : super(key: key);

  final String? svgSource;
  final Function()? onTap;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final Color? color;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    if (onTap != null) {
      return GestureDetector(onTap: onTap ?? () {}, child: buildView());
    }

    return buildView();
  }

  Widget buildView() {
    if (svgSource == '') {
      return Container();
    }

    final String kkSource = 'assets/images/svgs/$svgSource';
    final Widget kkImage = SvgPicture.asset(
      kkSource,
      width: width,
      height: height,
      color: color,
      fit: fit ?? BoxFit.cover,
    );

    return Container(
      padding: padding ?? EdgeInsets.all(0),
      child: kkImage,
    );
  }
}
