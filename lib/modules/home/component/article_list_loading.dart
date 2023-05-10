import 'package:flutter/material.dart';
import 'package:shareticket/constants/dimens.constant.dart';
import 'package:shareticket/constants/divider.constant.dart';
import 'package:shareticket/widget/shimmer/shimmer.dart';

class ArticleListLoading extends StatelessWidget {
  const ArticleListLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: Dimens.size16),
      child: Row(
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Blink(
                      height: 18,
                      width: 18,
                      isCircle: true,
                    ),
                    divideW6,
                    const Blink(height: 10, width: 60)
                  ],
                ),
                divide4,
                const Blink(height: 12, width: double.infinity),
                divide4,
                const Blink(height: 12, width: double.infinity),
                divide6,
                Row(
                  children: [
                    const Blink(height: 12, width: 50),
                    divideW4,
                    const Blink(
                      height: 5,
                      width: 5,
                      isCircle: true,
                    ),
                    divideW4,
                    const Blink(height: 12, width: 50)
                  ],
                )
              ],
            ),
          ),
          divideW10,
          const Blink(
            height: 85,
            width: 85,
          ),
        ],
      ),
    );
  }
}
