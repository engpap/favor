import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/functions/showToast.dart';
import 'package:project/functions/utilities.dart';
import 'package:project/helpers/storage.dart';
import 'package:project/models/bookedFavor.dart';
import 'package:project/models/callerPost.dart'; //to remove
import 'package:project/models/favorCategories.dart';
import 'package:project/models/favorConstants.dart';
import 'package:project/models/post.dart';
import 'package:project/screens/components/customHeadingDesc.dart';
import 'package:project/screens/feed/feed.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'package:project/services/favorService.dart';
import 'package:project/services/constantsService.dart';
import 'package:project/services/postService.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

String bookedListHeading = "Your Booked Favors";
String categoryListHeading = "Favor Categories";
String reccomendationListHeading = "Recommended for you";

class Feed_Screen_M extends StatefulWidget {
  const Feed_Screen_M({super.key});

  @override
  State<Feed_Screen_M> createState() => _Feed_Screen_MState();
}

class _Feed_Screen_MState extends State<Feed_Screen_M> {
  late Future<bool> isThereUserToken;
  @override
  void initState() {
    super.initState();
    isThereUserToken = Storage.isThereUserToken();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //
              Divider(
                height: Responsive.height(1, context),
                color: Colors.transparent,
              ),
              // FAVOR BOOKED
              FutureBuilder<bool>(
                future: isThereUserToken,
                builder: ((context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return snapshot.data!
                        // IF THERE ARE BOOKED FAVOR - display them
                        ? Container(
                          height: Responsive.heightFixOver(130, 40, context),
                          child: Column(
                            children: [
                              //HEADING
                              customHeading2(heading: "${bookedListHeading}", size: 22,),
                              // BOOKED LIST (scrollable horizontaly)
                              Expanded(child: Carousel_BookedFavorWidget())
                            ],
                          ),
                        )
                        // IF THERE ARE NO BOOKED FAVOR (or you're not logged in) - display empty container
                        : Container();
                  }
                  return CupertinoActivityIndicator(animating: false, radius: 20);
                }),
              ),
              //
              Divider(
                height: Responsive.height(1, context),
                color: Colors.transparent,
              ),              
              // FAVOR CATEGORIES
              Container(
                height: Responsive.heightFixOver(130, 40, context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // HEADING
                    customHeading2(heading: "${categoryListHeading}", size: 22,),
                    Divider(
                      height: Responsive.height(1, context),
                      color: Colors.transparent,
                    ),
                    // CATEGORY LIST (scrollable horizontaly)
                    Expanded(child: Carousel_FavorCategoryWidget()),
                  ],
                ),
              ),
              //
              Divider(
                height: Responsive.height(1, context),
                color: Colors.transparent,
              ),
              // FAVOR RECOMMENDATIONS
              // HEADING
              customHeading2(heading: "${reccomendationListHeading}", size: 22,),
              // RECOMMENDATION LIST (scrollable vertically) 
              RecommendedFavorWidgetsList_Widget(shrinkWrap: true), 
            ],
          ),
        ),
      ),
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
      primary: false, //
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
        itemBuilder: (context, item, index) => BookedFavorWidget(booked: item),
        firstPageProgressIndicatorBuilder: (_) =>
            Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}