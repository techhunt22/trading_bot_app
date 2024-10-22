import 'package:flutter/material.dart';


class DashedLinePainter extends CustomPainter {
  final bool isVertical;
  final Color color;
  DashedLinePainter(this.color, {required this.isVertical });

  @override
  void paint(Canvas canvas, Size size) {
    double dashLength = 5, dashSpace = 3, start = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width;

    while (start < (isVertical ? size.height : size.width)) {
      canvas.drawLine(
        isVertical ? Offset(0, start) : Offset(start, 0),
        isVertical ? Offset(0, start + dashLength) : Offset(start + dashLength, 0),
        paint,
      );
      start += dashLength + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}




class MySeparator extends StatelessWidget {
  const MySeparator({super.key, this.height = 1, this.color = Colors.black});
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}