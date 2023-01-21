import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/functions/showToast.dart';
import 'package:project/functions/utilities.dart';
import 'package:project/models/bookedFavor.dart';
import 'package:project/models/callerPost.dart'; //to remove
import 'package:project/models/favorCategories.dart';
import 'package:project/models/favorConstants.dart';
import 'package:project/models/post.dart';
import 'package:project/screens/feed/feed.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/services/favorService.dart';
import 'package:project/services/constantsService.dart';
import 'package:project/services/postService.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

String bookedListHeading = "Your Booked Favors";
String categoryListHeading = "Favor Categories";
String reccomendationListHeading = "Recommended for you";

class Feed_Screen_M extends StatelessWidget {
  const Feed_Screen_M({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Divider(
          height: Responsive.height(1, context),
          color: Colors.transparent,
        ),

        // FAVOR BOOKED
        // TODO: far comparire solo se il server ritorna dei booked favors
        Container(
          padding: EdgeInsets.only(left: 0, right: 0),
          height: Responsive.height(17, context),
          // BOOKED LIST (scrollable horizontaly)
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //HEADING
              Container(
                width: Responsive.width(100, context),
                padding: EdgeInsets.only(right: 8, left: 8),
                child: Text(
                  "${bookedListHeading}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: favorColors.PrimaryBlue,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              //ELEMENTS
              Expanded(child: Carousel_BookedFavorWidget()),
            ],
          ),
        ),
        Divider(
          height: Responsive.height(1, context),
          color: Colors.transparent,
        ),
        // FAVOR CATEGORIES
        Container(
          padding: EdgeInsets.only(left: 8, right: 8),
          height: Responsive.height(16, context),
          // CATEGORY LIST (scrollable horizontaly)
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //HEADING
              Container(
                width: Responsive.width(100, context),
                padding: EdgeInsets.only(right: 0, left: 0),
                child: Text(
                  "${categoryListHeading}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: favorColors.PrimaryBlue,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Divider(
                height: Responsive.height(1, context),
                color: Colors.transparent,
              ),
              //ELEMENTS
              Expanded(child: Carousel_FavorCategoryWidget()),
            ],
          ),
        ),
        Divider(
          height: Responsive.height(1, context),
          color: Colors.transparent,
        ),
        // FAVOR RECOMMENDATIONS
        Expanded(
          //color: Colors.lightBlue,

          // RECOMMENDATION LIST (scrollable vertically)
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //HEADING
              Container(
                width: Responsive.width(100, context),
                padding: EdgeInsets.only(right: 8, left: 8),
                child: Text(
                  "${reccomendationListHeading}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: favorColors.PrimaryBlue,
                  ),
                ),
              ),

              //ELEMENTS
              Expanded(
                child: RecommendedFavorWidgetsList_Widget(shrinkWrap: false),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Carousel_FavorCategoryWidget extends StatefulWidget {
  const Carousel_FavorCategoryWidget({super.key});

  @override
  State<Carousel_FavorCategoryWidget> createState() =>
      _Carousel_FavorCategoryWidgetState();
}

class _Carousel_FavorCategoryWidgetState
    extends State<Carousel_FavorCategoryWidget> {
  late Future<FavorCategories> favorCategories;

  @override
  void initState() {
    favorCategories = ConstantsService().getFavorCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FavorCategories>(
        future: favorCategories,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.favorCategories.length,
                itemBuilder: (context, index) {
                  return FavorCategoryWidget(
                    categoryName: snapshot.data!.favorCategories[index],
                  );
                });
          } else if (snapshot.hasError) {
            showToast(context, '${snapshot.error}');
          }
          // By default, show a loading spinner.
          return CupertinoActivityIndicator(animating: false, radius: 10);
        }));
  }
}

///  The attrbure "shrinkWrap" is used for centering the activity indicator and build the posts correctly based on the screen we are.
class RecommendedFavorWidgetsList_Widget extends StatefulWidget {
  RecommendedFavorWidgetsList_Widget({super.key, required this.shrinkWrap});

  bool shrinkWrap;

  @override
  State<RecommendedFavorWidgetsList_Widget> createState() =>
      _RecommendedFavorWidgetsList_WidgetState();
}

class _RecommendedFavorWidgetsList_WidgetState
    extends State<RecommendedFavorWidgetsList_Widget> {
  static const _pageSize = 4;
  final PagingController<int, Post> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(context, pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(BuildContext context, int pageKey) async {
    try {
      final newItems = await PostService().getPosts(context, pageKey);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Post>(
      shrinkWrap: widget.shrinkWrap,
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Post>(
          itemBuilder: (context, item, index) => FavorWidget(
                post: item,
              ),
          firstPageProgressIndicatorBuilder: (_) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoActivityIndicator(animating: false, radius: 10)
                ],
              )),
    );
  }
}

//TODO: da controllare la funzione del server (ho fatto solo copia ed incolla dal Carousel_FavorCategoryWidget)
class Carousel_BookedFavorWidget extends StatefulWidget {
  const Carousel_BookedFavorWidget({super.key});

  @override
  State<Carousel_BookedFavorWidget> createState() =>
      _Carousel_BookedFavorWidgetState();
}

class _Carousel_BookedFavorWidgetState
    extends State<Carousel_BookedFavorWidget> {
  static const _pageSize = 4;
  final PagingController<int, BookedFavor> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await FavorService().getBookedFavors(context, pageKey);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, BookedFavor>(
      scrollDirection: Axis.horizontal,
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<BookedFavor>(
        itemBuilder: (context, item, index) => BookedFavorWidget(
            categoryName: item.post.taskCategory, booked: item),
        firstPageProgressIndicatorBuilder: (_) =>
            Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}

//TODO: APPENA POSSIBILE REMOVE THIS
BookedFavor BOOKED = new BookedFavor(
    id: "id",
    bookedAt: DateTime(0),
    providerId: "providerId",
    callerId: "callerId",
    post: new CallerPost(
        id: "id",
        creatorId: "creatorId",
        createdAt: "createdAt",
        name: "name",
        surname: "surname",
        profilePicture: null,
        userType: "userType",
        taskCategory: "taskCategory",
        location: "location",
        favorStartTime: DateTime(0),
        description: "description",
        averageRatings: 2,
        rankingPosition: 1,
        rankingLocation: "rankingLocation",
        bio: "bio"));
