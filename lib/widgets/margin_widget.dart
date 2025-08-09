import 'package:flutter/material.dart';
import 'package:utility_extensions/extensions/context_extensions.dart';

class MarginWidget extends StatelessWidget {
  const MarginWidget({
    this.isSliver = false,
    this.isHorizontal = false,
    this.factor = 1.0,
    super.key,
  });

  final bool isSliver;
  final bool isHorizontal;
  final double factor;

  @override
  Widget build(BuildContext context) {
    double height = context.height;
    double width = context.width;
    if (isSliver) {
      return SliverToBoxAdapter(
        child: margin(height, width),
      );
    } else {
      return margin(height, width);
    }
  }

  Widget margin(double height, double width) {
    return SizedBox(
      height: isHorizontal ? null : height * 0.02 * factor,
      width: isHorizontal ? width * 0.03 * factor : null,
    );
  }
}
