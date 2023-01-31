import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/models/post.dart';
import 'package:project/screens/components/customCard.dart';
import 'package:project/screens/favor_information_page/favorInformationPage.dart';

class favorInformationPage_Screen_M extends StatelessWidget {
  favorInformationPage_Screen_M({
    super.key,
    required this.post,
    required this.userType,
  });

  Post? post;
  String userType;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        // FAVOR INFORMATION
        CustomCard(child: FavorInformation(post: post)),
        // FAVOR PERSON
        CustomCard(
          child: FavorPerson(post: post),
        ),
        // FAVOR BOOK
        BookFavorButton(
          post: post,
          userType: userType,
        ),
      ]),
    );
  }
}
