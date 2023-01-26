import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/models/post.dart';
import 'package:project/screens/components/customCard.dart';
import 'package:project/screens/favorInformationPage/favorInformationPage.dart';


class favorInformationPage_Screen_M extends StatelessWidget {
  favorInformationPage_Screen_M({
    super.key,
    required this.post,
  });

  Post? post;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        // FAVOR INFORMATION
        CustomCard(child: FavorInformation(post: post)),
        // FAVOR PERSON
        CustomCard(child: FavorPerson(post: post),),
        // FAVOR MAP
        CustomCard(
          padding: EdgeInsets.all(0),
          //margin: EdgeInsets.only(right: 9, left: 9),
          child: FavorMap(post: post),
        ),
        // FAVOR BOOK
        FavorBook(post: post),
      ]),
    );
  }
}
