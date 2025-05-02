import 'package:intl/intl.dart';

Map<String, String> formatDateTime(String rawDateTime) {
  try {
    final dateTime = DateTime.parse(rawDateTime);
    final day = DateFormat('dd').format(dateTime);
    final suffix = getDaySuffix(int.parse(day));
    final monthYear = DateFormat('MMMM, yyyy').format(dateTime);
    final time = DateFormat('HH:mm').format(dateTime);

    return {
      'date': '$day$suffix $monthYear',
      'time': time,
    };
  } catch (e) {
    return {
      'date': '',
      'time': '',
    };
  }
}

String getDaySuffix(int day) {
  if (day >= 11 && day <= 13) return 'th';
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
