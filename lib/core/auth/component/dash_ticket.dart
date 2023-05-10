import 'package:flutter/material.dart';

class DashTicket extends StatelessWidget {
  final double height;
  final Color color;

  const DashTicket({Key? key, this.height = 1, this.color = Colors.grey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 14.0;
        const dashHeight = 8.0;
        final dashCount = (boxWidth / (1.5 * dashWidth)).floor();

        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return Container(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100))),
              ),
            );
          }),
        );
      },
    );
  }
}
