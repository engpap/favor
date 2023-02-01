import 'package:flutter/cupertino.dart';
import 'package:mockito/mockito.dart';
import 'package:project/models/statistics.dart';
import 'package:project/services/adminService.dart';

class AdminServiceMock extends Mock implements AdminService {
  Future<Statistics?> getStatistics(BuildContext context) async {
    Map<String, int> statistics = {"LORETO": 2, "DERGANO": 3};
    return Statistics(stats: statistics);
  }
}
