library favorTime;

import 'package:intl/intl.dart';

// https://stackoverflow.com/questions/16126579/how-do-i-format-a-date-with-dart
final DateFormat formatter = DateFormat('MMM d, h:mm a');

// ACCEPT: a string in the format of formatter (above) 
// RETURN: a string in Iso8601
String formatterForServer(String date){
  DateTime _old = formatter.parse(date);
  print("OLD DATE");
  print(_old);
  DateTime newVariable = _old.copyWith(year: DateTime.now().year);
  print("DATE sent to server");
  print(newVariable.toIso8601String());
  return newVariable.toIso8601String();
}

extension MyDateUtils on DateTime {
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}