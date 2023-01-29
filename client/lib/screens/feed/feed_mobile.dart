import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/functions/showToast.dart';
import 'package:project/helpers/storage.dart';
import 'package:project/models/bookedFavor.dart';
import 'package:project/models/favorCategories.dart';
import 'package:project/models/post.dart';
import 'package:project/providers/app_provider.dart';
import 'package:project/screens/components/customHeadingDesc.dart';
import 'package:project/screens/feed/feed.dart';

import 'package:project/functions/favorColors.dart' as favorColors;

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

String bookedListHeading = "Your Booked Favors";
String categoryListHeading = "Favor Categories";
String reccomendationListHeading = "Recommended for you";

class Feed_Screen_M extends StatefulWidget {
  const Feed_Screen_M({super.key});

  @override
  State<Feed_Screen_M> createState() => _Feed_Screen_MState();
}

class _Feed_Screen_MState extends State<Feed_Screen_M> {
  // USER DATA
  late Future<bool> _isThereUserToken;
  late Future<bool> _userHasBookedSomeFavors;

  // RECOMMENDED FAVORS
  static const _pageSize = 4;
  PagingController<int, Post> _pagingController =
      PagingController(firstPageKey: 1);
  bool _shrinkWrap = true;

  // BOOKED FAVORS
  PagingController<int, BookedFavor> _pagingController_booked_favors =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _isThereUserToken = Storage.isThereUserToken();
    // At the beginning, it is false. This would allow to see the home without
    // having a valid token or having been signed in/up.
    _userHasBookedSomeFavors = refresh_hasUserBookedSomeFavors(context);

    _pagingController.addPageRequestListener((pageKey) {
      fetch_recommended_favors_page(context, pageKey);
    });

    _pagingController_booked_favors.addPageRequestListener((pageKey) {
      fetch_booked_favors_page(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: RefreshIndicator(
          color: favorColors.PrimaryBlue,
          backgroundColor: Colors.white,
          onRefresh: () async {
            _pagingController.refresh();
            _pagingController_booked_favors.refresh();
            refresh_hasUserBookedSomeFavors(context);
            return;
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                //
                Divider(
                  height: Responsive.height(1, context),
                  color: Colors.transparent,
                ),
                // FAVOR BOOKED
                FutureBuilder<bool>(
                  // if user HAS TOKEN, then try to show the booked favors
                  future: _isThereUserToken,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      // user has token
                      if (snapshot.data!) {
                        // show Booked Favors only if the return list from back-end is not empty
                        return FutureBuilder<bool>(
                          future: _userHasBookedSomeFavors,
                          builder: ((context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              // if user HAS BOOKED FAVORS (list is not empty)
                              if (snapshot.data!) {
                                return Container(
                                  height: Responsive.heightFixOver(
                                      130, 40, context),
                                  child: Column(
                                    children: [
                                      //HEADING
                                      customHeading2(
                                        heading: "${bookedListHeading}",
                                        size: 22,
                                      ),
                                      // BOOKED LIST (scrollable horizontaly)
                                      Expanded(
                                          child: Carousel_BookedFavors_Widget(
                                              context))
                                    ],
                                  ),
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            }
                            return CupertinoActivityIndicator(
                                animating: false, radius: 10);
                          }),
                        );
                      }
                    } else {
                      return SizedBox.shrink();
                    }
                    // WHILE WAITING
                    return CupertinoActivityIndicator(
                        animating: false, radius: 10);
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
                      customHeading2(
                        heading: "${categoryListHeading}",
                        size: 22,
                      ),
                      Divider(
                        height: Responsive.height(1, context),
                        color: Colors.transparent,
                      ),
                      // CATEGORY LIST (scrollable horizontaly)
                      Expanded(child: Carousel_FavorCategory_Widget()),
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
                List_RecommendedFavors_Widget(context, true),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Call api if user has a token. Then set the state in order to update
  /// the widget.
  /// If user has not the token, then we just return false
  /// assuming it has not not booked some favors.
  Future<bool> refresh_hasUserBookedSomeFavors(BuildContext context) async {
    bool isThereUserToken = await Storage.isThereUserToken();
    if (isThereUserToken) {
      var result = Provider.of<AppProvider>(context, listen: false)
          .hasUserBookedSomeFavors(context);
      setState(() {
        _userHasBookedSomeFavors = result;
      });
      return result;
    } else {
      return false;
    }
  }

  //RECOMMENDER LIST -------
  Widget List_RecommendedFavors_Widget(BuildContext context, bool shrinkWrap) {
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

  Future<void> fetch_recommended_favors_page(
      BuildContext context, int pageKey) async {
    try {
      final newItems = await Provider.of<AppProvider>(context, listen: false)
          .getPosts(context, pageKey);
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
  Widget Carousel_BookedFavors_Widget(BuildContext context) {
    return PagedListView<int, BookedFavor>(
      scrollDirection: Axis.horizontal,
      pagingController: _pagingController_booked_favors,
      builderDelegate: PagedChildBuilderDelegate<BookedFavor>(
        itemBuilder: (context, item, index) => BookedFavorWidget(booked: item),
        firstPageProgressIndicatorBuilder: (_) =>
            Center(child: CupertinoActivityIndicator()),
      ),
    );
  }

  Future<void> fetch_booked_favors_page(int pageKey) async {
    try {
      final newItems = await Provider.of<AppProvider>(context, listen: false)
          .getBookedFavors(context, pageKey);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController_booked_favors.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController_booked_favors.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController_booked_favors.error = error;
    }
  }
}

class Carousel_FavorCategory_Widget extends StatefulWidget {
  const Carousel_FavorCategory_Widget({super.key});

  @override
  State<Carousel_FavorCategory_Widget> createState() =>
      _Carousel_FavorCategory_WidgetState();
}

class _Carousel_FavorCategory_WidgetState
    extends State<Carousel_FavorCategory_Widget> {
  late Future<FavorCategories> favorCategories;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    favorCategories = Provider.of<AppProvider>(context).getFavorCategories();
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
                    key: Key("favor_category_${index}"),
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
