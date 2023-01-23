import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/functions/utilities.dart';
import 'package:project/models/favorConstants.dart';
import 'package:project/models/leaderboard.dart';
import 'package:project/models/post.dart';
import 'package:project/screens/favor/favor.dart';
import 'package:project/screens/feed/feed.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/leaderboard/leaderboard.dart';
import 'package:project/services/constantsService.dart';
import 'package:project/services/leaderboardService.dart';
import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/services/postService.dart';

import '../feed/feed_mobile.dart';

class Explore_Screen_M extends StatefulWidget {
  Explore_Screen_M({super.key});

  @override
  State<Explore_Screen_M> createState() => _Explore_Screen_MState();
}

class _Explore_Screen_MState extends State<Explore_Screen_M> {
  late Future<List<Post>> posts;

  final TextEditingController searchBarTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initial data is just as recommended favors data!
    posts = PostService().getPosts(context, 1);
  }

  Future<List<Post>> searchPosts() {
    return posts = PostService().getPostsBySearch(
        context: context,
        searchQuery: searchBarTextController.text,
        userTypeToSearch:
            UserMode_inherited.of(context).stateWidget.getOppositeUserMode());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child:
          LayoutBuilder(//Otherwiese content would be under the bottom nav bar.
              builder: (BuildContext context, BoxConstraints constraints) {
        final double navBarHeight =
            50.0; //Default height based on documentation -> https://api.flutter.dev/flutter/cupertino/CupertinoTabBar/height.html
        final double availableHeight =
            constraints.biggest.height - navBarHeight;
        return CustomScrollView(slivers: [
          SliverAppBar(
              floating: true,
              snap: true,
              pinned: false,
              centerTitle: false,
              backgroundColor: Colors.white,
              elevation: 0,
              title: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: favorColors.IntroBg,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(90),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0.5,
                        blurRadius: 5,
                        offset: Offset(0, 1),
                      ),
                    ]),
                child: CupertinoTextField(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: favorColors.PrimaryBlue,
                    ),
                    //textInputAction: widget.textInputAction, //widget
                    //keyboardType: widget.textInputType, //widget
                    padding: EdgeInsets.only(top: 9, bottom: 9),
                    decoration: BoxDecoration(
                      color: favorColors.IntroBg,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(90),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 0.5,
                          blurRadius: 5,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    cursorColor: favorColors.Yellow,
                    cursorWidth: 2,
                    cursorRadius: Radius.circular(10),
                    // prefix button
                    prefix: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Icon(
                        CupertinoIcons.search,
                        color: favorColors.PrimaryBlue,
                      ),
                      onPressed: null,
                    ),
                    // clear button
                    suffix: CupertinoButton(
                      padding:
                          EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                      child: Icon(
                        CupertinoIcons.xmark_circle_fill,
                        color: favorColors.Yellow.withOpacity(0.8),
                      ),
                      onPressed: () => searchBarTextController.clear(),
                    ),
                    maxLength: 30, // reasonable value
                    maxLines: 1, // reasonable value
                    placeholder:
                        "Search for ${UserMode_inherited.of(context).stateWidget.getOppositeUserMode()} favors",
                    placeholderStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                    controller: searchBarTextController,
                    onSubmitted: (value) {
                      print('Submitted [${searchBarTextController}]: $value');
                      this.searchPosts();
                    }),
              )),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return FutureBuilder<List<Post>>(
                    future: posts,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(children: [
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, itemIndex) {
                                return FavorWidget(
                                    post: snapshot.data![itemIndex]);
                              })
                        ]);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return CupertinoActivityIndicator(
                          animating: false, radius: 10);
                    }));
              },
              childCount: 1,
            ),
          ),
        ]);
      }),
    );
  }
}
