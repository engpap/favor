import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project/errors/errorHandling.dart';
import 'package:project/functions/showToast.dart';
import 'package:project/models/bookedFavor.dart';
import 'dart:convert';
import 'package:project/constants/globalVars.dart';
import 'package:project/providers/userProvider.dart';
import 'package:provider/provider.dart';

class FavorService {
  Future<List<BookedFavor>> getBookedFavors(
      BuildContext context, int pageNumber) async {
    List<BookedFavor> bookedFavors = [];
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response response = await http.get(
          Uri.parse('$uri/favors/getBookedFavors?page=${pageNumber}'),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          });

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(response.body)['data'].length; i++)
              bookedFavors.add(
                  BookedFavor.fromJson(jsonDecode(response.body)['data'][i]));
          });
    } catch (error) {
      showToast(context, error.toString());
    }
    return bookedFavors;
  }

  /**
   * This method should be called only by PROVIDERS.
   */
  Future<void> markFavorAsCompleted(
      BuildContext context, int bookedFavorId) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response response = await http.post(
        Uri.parse('$uri/favors/complete'),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(bookedFavorId),
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            // TODO: review page
          });
    } catch (error) {
      showToast(context, error.toString());
    }
  }
}
