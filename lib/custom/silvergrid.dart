<<<<<<< HEAD
// ignore_for_file: annotate_overrides, overridden_fields

=======
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
import 'package:flutter/rendering.dart';

class CustomSliverGridDelegate
    extends SliverGridDelegateWithFixedCrossAxisCount {
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double additionalSpacing;
  final int columnsBeforeSpacing;

  CustomSliverGridDelegate({
<<<<<<< HEAD
    required super.crossAxisCount,
=======
    required int crossAxisCount,
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    required this.additionalSpacing,
    required this.columnsBeforeSpacing,
<<<<<<< HEAD
  });

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final double tileWidth =
        (constraints.crossAxisExtent -
=======
  }) : super(crossAxisCount: crossAxisCount);

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final double tileWidth = (constraints.crossAxisExtent -
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
            (crossAxisCount - 1) * crossAxisSpacing -
            ((crossAxisCount - 1) ~/ columnsBeforeSpacing) *
                additionalSpacing) /
        crossAxisCount;
    final double tileHeight = tileWidth;

    return SliverGridRegularTileLayout(
      crossAxisCount: crossAxisCount,
      mainAxisStride: tileHeight + mainAxisSpacing,
      crossAxisStride: tileWidth + crossAxisSpacing,
      childMainAxisExtent: tileHeight,
      childCrossAxisExtent: tileWidth,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
      additionalCrossAxisSpacing: additionalSpacing,
      columnsBeforeSpacing: columnsBeforeSpacing,
    );
  }

  @override
  bool shouldRelayout(CustomSliverGridDelegate oldDelegate) {
    return oldDelegate.crossAxisCount != crossAxisCount ||
        oldDelegate.mainAxisSpacing != mainAxisSpacing ||
        oldDelegate.crossAxisSpacing != crossAxisSpacing ||
        oldDelegate.additionalSpacing != additionalSpacing ||
        oldDelegate.columnsBeforeSpacing != columnsBeforeSpacing;
  }
}

class SliverGridRegularTileLayout extends SliverGridLayout {
  final int crossAxisCount;
  final double mainAxisStride;
  final double crossAxisStride;
  final double childMainAxisExtent;
  final double childCrossAxisExtent;
  final bool reverseCrossAxis;
  final double additionalCrossAxisSpacing;
  final int columnsBeforeSpacing;

<<<<<<< HEAD
  const SliverGridRegularTileLayout({
=======
  SliverGridRegularTileLayout({
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
    required this.crossAxisCount,
    required this.mainAxisStride,
    required this.crossAxisStride,
    required this.childMainAxisExtent,
    required this.childCrossAxisExtent,
    required this.reverseCrossAxis,
    required this.additionalCrossAxisSpacing,
    required this.columnsBeforeSpacing,
  });

  @override
  SliverGridGeometry getGeometryForChildIndex(int index) {
    final int row = index ~/ crossAxisCount;
    final int column = index % crossAxisCount;

    double crossAxisOffset = column * crossAxisStride;
    if (column >= columnsBeforeSpacing) {
      crossAxisOffset +=
          ((column - columnsBeforeSpacing) ~/ columnsBeforeSpacing + 1) *
<<<<<<< HEAD
          additionalCrossAxisSpacing;
=======
              additionalCrossAxisSpacing;
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
    }

    final double mainAxisOffset = row * mainAxisStride;
    return SliverGridGeometry(
      scrollOffset: mainAxisOffset,
<<<<<<< HEAD
      crossAxisOffset:
          reverseCrossAxis
              ? crossAxisStride - crossAxisOffset - childCrossAxisExtent
              : crossAxisOffset,
=======
      crossAxisOffset: reverseCrossAxis
          ? crossAxisStride - crossAxisOffset - childCrossAxisExtent
          : crossAxisOffset,
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
      mainAxisExtent: childMainAxisExtent,
      crossAxisExtent: childCrossAxisExtent,
    );
  }

  @override
  int getMaxChildIndexForScrollOffset(double scrollOffset) {
    return (scrollOffset / mainAxisStride).ceil() * crossAxisCount - 1;
  }

  @override
  int getMinChildIndexForScrollOffset(double scrollOffset) {
    return (scrollOffset / mainAxisStride).floor() * crossAxisCount;
  }

  @override
  double computeMaxScrollOffset(int childCount) {
    final int rowCount = (childCount + crossAxisCount - 1) ~/ crossAxisCount;
    return rowCount * mainAxisStride;
  }
}
