import 'package:flutter_test/flutter_test.dart';
import 'package:project/functions/favorTime.dart';

void main() {
  test('Test formatterForServer function', () {
    final dateString = 'Jan 1, 1:00 PM';
    final expectedString =
        DateTime.now().year.toString() + '-01-01T13:00:00.000';
    final result = formatterForServer(dateString);

    expect(result, expectedString);
  });
}
