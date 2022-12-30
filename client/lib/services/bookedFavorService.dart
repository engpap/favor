import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project/errors/errorHandling.dart';
import 'package:project/functions/showToast.dart';
import 'package:project/models/bookedFavor.dart';
import 'dart:convert';
import 'package:project/constants/globalVars.dart';

class BookedFavorService {
  Future<List<BookedFavor>> getBookedFavors(
      BuildContext context, int pageNumber) async {
    List<BookedFavor> bookedFavors = [];
    try {
      http.Response response = await http.get(
          Uri.parse('$uri/posts/getBookedFavors?page=${pageNumber}'),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
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
}
