import 'package:flutter_test/flutter_test.dart';
import 'package:project/models/statistics.dart';

void main() {
  group('Statistics', () {
    test('Statistics can be created from JSON', () {
      final String source =
          '[{"_id": "LORETO", "completedCount": 4}, {"_id": "DERGANO", "completedCount": 5}]';
      final Statistics statistics = Statistics.fromJson(source);

      expect(
          statistics.stats,
          equals({
            "LORETO": 4,
            "DERGANO": 5,
          }));
    });
  });
}
