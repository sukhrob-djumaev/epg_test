import 'package:epg_test/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayBarItem extends StatelessWidget {
  final DateTime day;
  final VoidCallback onTap;
  final bool isActive;
  const DayBarItem({super.key, required this.day, required this.onTap, required this.isActive});

  @override
  Widget build(BuildContext context) {
    String dayText = DateFormat('dd.MM').format(day);
    if (day.isToday) {
      dayText = 'Today';
    } else if (day.isYesterday) {
      dayText = 'Yesterday';
    } else if (day.isTomorrow) {
      dayText = 'Tomorrow';
    }
    return GestureDetector(
      onTap: onTap,
      child: Text(
        dayText,
        textAlign: TextAlign.center,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(decoration: isActive ? TextDecoration.underline : null),
      ),
    );
  }
}
