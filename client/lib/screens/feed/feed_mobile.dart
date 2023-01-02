import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/functions/showToast.dart';
import 'package:project/functions/utilities.dart';
import 'package:project/models/bookedFavor.dart';
import 'package:project/models/favorCategories.dart';
import 'package:project/models/favorConstants.dart';
import 'package:project/models/post.dart';
import 'package:project/screens/feed/feed.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/services/bookedFavorService.dart';
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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Divider(
          height: Responsive.height(1, context),
          color: Colors.transparent,
        ),

        // FAVOR BOOKED
        // TODO: far comparire solo se il server ritorna dei booked favors
        Container(
          padding: EdgeInsets.only(left: 8, right: 8),
          height: Responsive.height(20, context),
          // BOOKED LIST (scrollable horizontaly)
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //HEADING
              Container(
                width: Responsive.width(100, context),
                padding: EdgeInsets.only(right: 9, left: 9),
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
              Divider(
                height: Responsive.height(1, context),
                color: Colors.transparent,
              ),
              //ELEMENTS
              Container(
                  constraints:
                      BoxConstraints(maxHeight: Responsive.height(15, context)),
                  child: Carousel_BookedFavorWidget()),
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
          height: Responsive.height(25, context),
          // CATEGORY LIST (scrollable horizontaly)
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //HEADING
              Container(
                width: Responsive.width(100, context),
                padding: EdgeInsets.only(right: 9, left: 9),
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
              Container(
                  constraints:
                      BoxConstraints(maxHeight: Responsive.height(16, context)),
                  child: Carousel_FavorCategoryWidget()),
            ],
          ),
        ),
        Divider(
          height: Responsive.height(1, context),
          color: Colors.transparent,
        ),

        // FAVOR RECOMMENDATIONS
        Container(
          padding: EdgeInsets.only(left: 8, right: 8),
          height: Responsive.height(20, context), //TODO: 50
          // RECOMMENDATION LIST (scrollable vertically)
          child: Column(
            children: [
              //HEADING
              Container(
                width: Responsive.width(100, context),
                padding: EdgeInsets.only(right: 9, left: 9),
                child: Text(
                  "${reccomendationListHeading}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: favorColors.PrimaryBlue,
                  ),
                ),
              ),
              Divider(
                height: Responsive.height(1, context),
                color: Colors.transparent,
              ),
              //ELEMENTS
              Expanded(
                child: Carousel_RecommendedFavorWidgetWidget(),
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
                    categoryImage: "assets/images/bg_music_01.jpg",
                    categoryName: Utilities.replaceEmptySpaceWithNewline(
                        snapshot.data!.favorCategories[index]),
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

class Carousel_RecommendedFavorWidgetWidget extends StatefulWidget {
  const Carousel_RecommendedFavorWidgetWidget({super.key});

  @override
  State<Carousel_RecommendedFavorWidgetWidget> createState() =>
      _Carousel_RecommendedFavorWidgetWidgetState();
}

class _Carousel_RecommendedFavorWidgetWidgetState
    extends State<Carousel_RecommendedFavorWidgetWidget> {
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
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Post>(
          itemBuilder: (context, item, index) => RecommendedFavorWidget(
                post: item,
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
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          await BookedFavorService().getBookedFavors(context, pageKey);
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
    return ListView(scrollDirection: Axis.horizontal, children: [
      //TODO: passare quali widget diplayare
      BookedFavorWidget(
        categoryImage: "assets/images/bg_music_01.jpg",
        categoryName: "Booked 1",
      ),
      BookedFavorWidget(
        categoryImage: "assets/images/bg_music_02.jpg",
        categoryName: "Booked 2",
      ),
      BookedFavorWidget(
        categoryImage: "assets/images/bg_music_01.jpg",
        categoryName: "Booked 3",
      ),
      BookedFavorWidget(
        categoryImage: "assets/images/bg_music_02.jpg",
        categoryName: "Booked 4",
      ),
      BookedFavorWidget(
        categoryImage: "assets/images/bg_music_02.jpg",
        categoryName: "Booked 5",
      ),
      BookedFavorWidget(
        categoryImage: "assets/images/bg_music_01.jpg",
        categoryName: "Booked 6",
      ),
    ]);
  }
}
