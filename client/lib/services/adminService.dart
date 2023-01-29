import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project/errors/error_handling.dart';
import 'package:project/models/statistics.dart';
import 'dart:convert';
import 'package:project/constants/globalVars.dart';
import 'package:project/helpers/storage.dart';

class AdminService {
  Future<Statistics?> getStatistics(BuildContext context) async {
    Statistics? statistics;
    try {
      http.Response response =
          await http.get(Uri.parse('$uri/admin/getStatistics'), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'x-auth-token': await Storage.getUserToken(),
      });

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            statistics = Statistics.fromList(jsonDecode(response.body));
          });
    } catch (error) {
      throw Exception(">>> getStatistics exception: " + error.toString());
    }
    return statistics;
  }
}
