import 'package:flutter/material.dart';
import 'package:project/functions/responsive.dart';
import 'package:project/models/providerPost.dart';
import 'package:project/screens/components/customCard.dart';
import 'package:project/screens/feed/feed.dart';

import 'package:project/functions/favorColors.dart' as favorColors;
import 'globals.dart' as globals;
import '../favorInformationPage/globals.dart' as globals_fip;

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
        // FAVOR CATEGORIES
        Container(
          padding: EdgeInsets.only(left: 8, right: 8),
          height: Responsive.height(20, context),
          // CATEGORY LIST (scrollable horizontaly)
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //HEADING
              Container(
                width: Responsive.width(100, context),
                padding: EdgeInsets.only(right: 9, left: 9),
                child: Text(
                  "${globals.categoryListHeading}",
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
                  child: Carosel_FavorCategoryWidget()),
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
          height: Responsive.height(50, context),
          // RECOMMENDATION LIST (scrollable vertically)
          child: Column(
            children: [
              //HEADING
              Container(
                width: Responsive.width(100, context),
                padding: EdgeInsets.only(right: 9, left: 9),
                child: Text(
                  "${globals.reccomendationListHeading}",
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
                child: Carosel_FavorReccomenderWidget(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Carosel_FavorCategoryWidget extends StatelessWidget {
  const Carosel_FavorCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(scrollDirection: Axis.horizontal, children: [
      //TODO: passare quali widget diplayare
      FavorCategoryWidget(
        categoryImage: "assets/images/bg_music_01.jpg",
        categoryName: "Category 1",
      ),
      FavorCategoryWidget(
        categoryImage: "assets/images/bg_music_02.jpg",
        categoryName: "Category 2",
      ),
      FavorCategoryWidget(
        categoryImage: "assets/images/bg_music_01.jpg",
        categoryName: "Category 3",
      ),
      FavorCategoryWidget(
        categoryImage: "assets/images/bg_music_02.jpg",
        categoryName: "Category 4",
      ),
      FavorCategoryWidget(
        categoryImage: "assets/images/bg_music_02.jpg",
        categoryName: "Category 5",
      ),
      FavorCategoryWidget(
        categoryImage: "assets/images/bg_music_01.jpg",
        categoryName: "Category 6",
      ),
    ]);
  }
}


class Carosel_FavorReccomenderWidget extends StatefulWidget {
  const Carosel_FavorReccomenderWidget({super.key});

  @override
  State<Carosel_FavorReccomenderWidget> createState() => _Carosel_FavorReccomenderWidgetState();
}

class _Carosel_FavorReccomenderWidgetState extends State<Carosel_FavorReccomenderWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(scrollDirection: Axis.vertical, children: [
      //TODO: passare quali widget diplayare
      FavorReccomendationWidget(
        heading: globals_fip.heading, //ProviderPost.taskCategory
        area: globals_fip.area, //ProviderPost.location
        information: globals_fip.information, //ProviderPost.description
        startTime: globals_fip.formatter.format(globals_fip.startTime), //ProviderPost.availabilityStartTime
        endTime: globals_fip.formatter.format(globals_fip.endTime), //ProviderPost.availabilityEndTime
        personImage: globals_fip.personImage, //TODO: 
        personName: globals_fip.personName, //TODO:
        personRole: globals_fip.personRole, //ProviderPost.userType
        personRating: globals_fip.personRating, //posizione classifica TODO:
        starsColor: globals_fip.starsColor, //TODO:
      ),

    ]);
  }
}

/** 
class CharacterListView extends StatefulWidget {
  @override
  _CharacterListViewState createState() => _CharacterListViewState();
}

class _CharacterListViewState extends State<CharacterListView> {
  static const _pageSize = 20;

  final PagingController<int, CharacterSummary> _pagingController =
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
      final newItems = await RemoteApi.getCharacterList(pageKey, _pageSize);
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
  Widget build(BuildContext context) => 
      PagedListView<int, CharacterSummary>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<CharacterSummary>(
          itemBuilder: (context, item, index) => CharacterListItem(
            character: item,
          ),
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
*/
