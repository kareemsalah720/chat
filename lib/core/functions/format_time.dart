  import 'package:intl/intl.dart';

String formatTime(DateTime dateTime) {
  // صيغة الوقت "8:42"
  return DateFormat.jms().format(DateTime.now());
}
