import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/functions/showToast.dart';
import 'package:project/helpers/storage.dart';
import 'package:project/models/bookedFavor.dart';
import 'package:project/models/favorCategories.dart';
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

  // RECOMMEDED
  static const _pageSize = 4;
  PagingController<int, Post> _pagingController =
      PagingController(firstPageKey: 1);
  bool _shrinkWrap = true;
  // BOOKED
  PagingController<int, BookedFavor> _pagingControllerB =
      PagingController(firstPageKey: 1);
  late Future<bool> isNotEmptyBookedList;

  @override
  void initState() {
    super.initState();
    isThereUserToken = Storage.isThereUserToken();

    _pagingController.addPageRequestListener((pageKey) {
      fetchPage(context, pageKey);
    });

    _pagingControllerB.addPageRequestListener((pageKey) {
      isNotEmptyBookedList = fetchPageB(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Center(
        child: RefreshIndicator(
          color: favorColors.PrimaryBlue,
          backgroundColor: Colors.white,
          onRefresh: () async {
            _pagingController.refresh();
            _pagingControllerB.refresh();
            return;
          },
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
                FutureBuilder(
                  future: isThereUserToken,
                  builder: ((context, snapshot) {
                    // if user HAS TOKEN
                    if (snapshot.hasData && snapshot.data != null) {
                      if (snapshot.data!) {
                        return 
                            /**
                             * TODO: riprovare a fixarlo
                            FutureBuilder(
                              future: isNotEmptyBookedList,
                              builder: ((context, snapshot) {
                                // if user HAS BOOKED FAVORS
                                if (snapshot.hasData && snapshot.data != null) {
                                  if (snapshot.data!){
                                    return 
                            */
                                    Container(
                                      height:Responsive.heightFixOver(130, 40, context),
                                      child: Column(
                                        children: [
                                          //HEADING
                                          customHeading2(
                                            heading: "${bookedListHeading}",
                                            size: 22,
                                          ),
                                          // BOOKED LIST (scrollable horizontaly)
                                          Expanded(child: buildBooked(context))
                                        ],
                                      ),
                                    );
                              /**
                                  } else {
                                    // if user HAS NO BOOKED FAVORS
                                    return Container();
                                  }
                                }
                                return CupertinoActivityIndicator(animating: false, radius: 20);
                              }),
                            );
                            */
                      } else {
                        // if user HAS NO TOKEN
                        return Container();
                      }
                    }
                    // WHILE WAITING
                    return CupertinoActivityIndicator(animating: false, radius: 20);
                  }
                  ),
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
                      customHeading2(
                        heading: "${categoryListHeading}",
                        size: 22,
                      ),
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
                customHeading2(
                  heading: "${reccomendationListHeading}",
                  size: 22,
                ),
                // RECOMMENDATION LIST (scrollable vertically)
                //RecommendedFavorWidgetsList_Widget(shrinkWrap: true),
                buildRec(context, true),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //RECOMMENDER LIST -------
  Widget buildRec(BuildContext context, bool shrinkWrap) {
    return PagedListView<int, Post>(
      primary: false, //
      shrinkWrap: _shrinkWrap,
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

  Future<void> fetchPage(BuildContext context, int pageKey) async {
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

  // BOOKED LIST ----
  Widget buildBooked(BuildContext context) {
    return PagedListView<int, BookedFavor>(
      scrollDirection: Axis.horizontal,
      pagingController: _pagingControllerB,
      builderDelegate: PagedChildBuilderDelegate<BookedFavor>(
        itemBuilder: (context, item, index) => BookedFavorWidget(booked: item),
        firstPageProgressIndicatorBuilder: (_) =>
            Center(child: CupertinoActivityIndicator()),
      ),
    );
  }

  Future<bool> fetchPageB(int pageKey) async {
    try {
      final newItems = await FavorService().getBookedFavors(context, pageKey);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingControllerB.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingControllerB.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingControllerB.error = error;
    }
    // isNotEmptyBookedList
    printStatus("CI SONO ELEMENTI IN LISTA? -- ${_pagingControllerB.itemList!.isNotEmpty}");
    return _pagingControllerB.itemList!.isNotEmpty;
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
