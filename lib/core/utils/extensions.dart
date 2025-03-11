extension DateTimeX on DateTime {
  bool isAtSameDayAs(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool get isToday => isAtSameDayAs(DateTime.now());

  bool get isTomorrow => isAtSameDayAs(DateTime.now().add(Duration(days: 1)));

  bool get isYesterday => isAtSameDayAs(DateTime.now().subtract(Duration(days: 1)));
}
