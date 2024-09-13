import 'package:intl/intl.dart';

extension ReadableDateTime on DateTime {
  /// Formats the [DateTime] object into a readable string format like "10th September, 2024".
  String format() {
    String day = DateFormat('d').format(this);
    String suffix = _getDaySuffix(int.parse(day));
    return "${day}${suffix} ${DateFormat('MMMM, yyyy').format(this)}";
  }

  /// Returns the appropriate suffix for a given day of the month.
  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
