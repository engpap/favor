import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project/errors/error_handling.dart';
import 'package:project/functions/showToast.dart';
import 'package:project/models/bookedFavor.dart';
import 'dart:convert';
import 'package:project/constants/globalVars.dart';
import 'package:project/helpers/storage.dart';
import 'package:project/providers/user_provider.dart';
import 'package:provider/provider.dart';

class FavorService {
  Future<List<BookedFavor>> getBookedFavors(
      BuildContext context, int pageNumber) async {
    List<BookedFavor> bookedFavors = [];
    try {
      http.Response response = await http.get(
          Uri.parse('$uri/favors/getBookedFavors?page=${pageNumber}'),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'x-auth-token': await Storage.getUserToken(),
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
      throw Exception(">>> bookFavor exception: " + error.toString());
      //showToast(context, error.toString());
    }
    return bookedFavors;
  }

  /**
   * This method should be called only by PROVIDERS.
   */
  Future<void> markFavorAsCompleted(
      BuildContext context, int bookedFavorId) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/favors/${bookedFavorId}/completeFavor'),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'x-auth-token': await Storage.getUserToken(),
        },
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showToast(context, "You have successfully completed a Favor!");
          });
    } catch (error) {
      throw Exception(
          ">>> markFavorAsCompleted exception: " + error.toString());
      //showToast(context, error.toString());
    }
  }

  Future<void> rateFavor(
      BuildContext context, int bookedFavorId, double rating) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/favors/${bookedFavorId}/rateFavor'),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'x-auth-token': await Storage.getUserToken(),
        },
        body: jsonEncode(rating),
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showToast(context, "You have successfully rated a Favor!");
          });
    } catch (error) {
      throw Exception(">>> rateFavor exception: " + error.toString());
      //showToast(context, error.toString());
    }
  }
}
