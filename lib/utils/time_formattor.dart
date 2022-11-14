//Get time and date in a string format from milliseconds
import 'package:intl/intl.dart';

String getTimeAndDate(String milliseconds) {
  var date = DateTime.fromMillisecondsSinceEpoch(int.parse(milliseconds));
  var formatter = DateFormat('dd-MM-yyyy hh:mm a');
  return formatter.format(date);
}
