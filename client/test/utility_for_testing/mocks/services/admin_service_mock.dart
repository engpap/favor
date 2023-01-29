import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:project/errors/error_handling.dart';
import 'package:project/models/statistics.dart';
import 'dart:convert';
import 'package:project/constants/globalVars.dart';
import 'package:project/helpers/storage.dart';
import 'package:project/services/adminService.dart';

class AdminServiceMock extends Mock implements AdminService {
  Future<Statistics?> getStatistics(BuildContext context) async {
    Map<String, int> statistics = {"LORETO": 2, "DERGANO": 3};
    return Statistics(stats: statistics);
  }
}
