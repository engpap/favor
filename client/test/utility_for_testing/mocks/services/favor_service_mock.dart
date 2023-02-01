import 'package:flutter/cupertino.dart';
import 'package:mockito/mockito.dart';
import 'package:project/models/bookedFavor.dart';
import 'package:project/services/favorService.dart';
import '../dummy_models.dart';

class FavorServiceMock extends Mock implements FavorService {
  Future<List<BookedFavor>> getBookedFavors(
      BuildContext context, int pageNumber) async {
    return [dummy_bookedFavor1, dummy_bookedFavor2];
  }

  /// Request the first page of booked favors. If there is at least one
  /// booked favor, then it returns true, otherwise it returns false.
  Future<bool> hasUserBookedSomeFavors(BuildContext context) async {
    return true;
  }

  /**
   * This method should be called only by PROVIDERS.
   */
  Future<bool> markFavorAsCompleted(
      BuildContext context, String bookedFavorId) async {
    return true;
  }

  Future<void> rateFavor(
      BuildContext context, String bookedFavorId, double rating) async {}
}
