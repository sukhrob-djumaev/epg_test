import 'package:epg_test/features/epg/widgets/day_bar_item.dart';
import 'package:flutter/material.dart';

class DayBar extends StatelessWidget {
  final PageController controller;
  final void Function(int index) onPageChanged;
  final int activeIndex;
  const DayBar({super.key, required this.controller, required this.onPageChanged, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      onPageChanged: onPageChanged,
      itemBuilder:
          (context, index) => DayBarItem(
            onTap: () => onPageChanged(index),
            day: DateTime.now().add(Duration(days: index - 100)),
            isActive: index == activeIndex,
          ),
    );
  }
}
