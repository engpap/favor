import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/models/post.dart';
import 'package:project/providers/app_provider.dart';
import 'package:project/screens/feed/feed.dart';
import 'package:project/screens/home.dart';
import 'package:project/functions/favorColors.dart' as favorColors;

import 'package:project/screens/explore/providerExplore.dart';
import 'package:provider/provider.dart';

class Explore_Screen_M extends StatefulWidget {
  Explore_Screen_M({super.key});

  @override
  State<Explore_Screen_M> createState() => _Explore_Screen_MState();
}

class _Explore_Screen_MState extends State<Explore_Screen_M> {
  late Future<List<Post>> posts;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initial data is just as recommended favors data!
    posts = Provider.of<AppProvider>(context).getPosts(context, 1);
  }

  Future<List<Post>> searchPosts() {
    return posts = Provider.of<AppProvider>(context).getPostsBySearch(
        context: context,
        searchQuery: context.read<ExploreQuery>().text,
        userTypeToSearch:
            UserMode_inherited.of(context).stateWidget.getOppositeUserMode());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Center(
          // REFRESH
          child: RefreshIndicator(
            color: favorColors.PrimaryBlue,
            backgroundColor: Colors.white,
            onRefresh: () async {
              setState(() {});
              return;
            },
            child: Column(children: [
              // SEARCH BAR
              Container(
                  margin: EdgeInsets.only(right: 9, left: 9),
                  child: buildSearchBar(context)),
              // ITEMS
              // used this method just to rebuild when a userMode change
              UserMode_inherited.of(context).stateWidget.isUserModeAs_caller()
                  ? buildItems(context)
                  : buildItems(context),
            ]),
          ),
        ));
  }

  Widget buildItems(BuildContext context) {
    searchPosts();
    return Expanded(
      child: FutureBuilder<List<Post>>(
          future: posts,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, itemIndex) {
                    return FavorWidget(
                      key: Key("favor_widget_${itemIndex}"),
                      post: snapshot.data![itemIndex],
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return CupertinoActivityIndicator(animating: false, radius: 10);
          })),
    );
  }

  //SEARCH BAR
  Widget buildSearchBar(BuildContext context) {
    return CupertinoTextField(
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: favorColors.PrimaryBlue,
        ),
        textInputAction: TextInputAction.done,
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
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.xmark_circle_fill,
            color: favorColors.Yellow.withOpacity(0.8),
          ),
          onPressed: () => context.read<ExploreQuery>().clear(),
        ),
        maxLength: 30, // reasonable value
        maxLines: 1, // reasonable value
        placeholder:
            "Search for ${UserMode_inherited.of(context).stateWidget.getOppositeUserMode()} favors",
        placeholderStyle: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.normal,
        ),
        controller: context.watch<ExploreQuery>().controller,
        onSubmitted: (value) {
          setState(() {});
          print('Submitted [${context.read<ExploreQuery>()}]: $value');
          this.searchPosts();
        });
  }
}
