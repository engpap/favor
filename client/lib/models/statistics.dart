import 'dart:convert';
import 'package:project/functions/jsonToDartFunctions.dart';

class Statistics {
  final Map<String, int> stats;

  Statistics({
    required this.stats,
  });

  ///The following code has the purpose of JSON stringify the user object.
  Statistics.fromList(List<dynamic> json)
      : stats = convertListIntoMap(json, '_id', 'completedCount');

  factory Statistics.fromJson(String source) =>
      Statistics.fromList(json.decode(source));
}
