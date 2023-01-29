import 'package:flutter/cupertino.dart';
import 'package:project/models/bookedFavor.dart';
import 'package:project/models/favorCategories.dart';
import 'package:project/models/favorConstants.dart';
import 'package:project/models/leaderboard.dart';
import 'package:project/models/post.dart';
import 'package:project/models/profileConstants.dart';
import 'package:project/models/statistics.dart';
import 'package:project/models/user.dart';
import 'package:project/services/adminService.dart';
import 'package:project/services/apis/google_calendar_api_wrapper.dart';
import 'package:project/services/authService.dart';
import 'package:project/services/constantsService.dart';
import 'package:project/services/favorService.dart';
import 'package:project/services/leaderboardService.dart';
import 'package:project/services/postService.dart';
import 'package:project/services/profileService.dart';

class AppProvider extends ChangeNotifier {
  // ----------- SERVICES -----------
  final AdminService _adminService;
  final AuthService _authService;
  final ConstantsService _constantsService;
  final FavorService _favorService;
  final LeaderboardService _leaderboardService;
  final PostService _postService;
  final ProfileService _profileService;
  final GoogleCalendarApiWrapper _googleCalendarApiWrapper;

  // ----------- CONSTRUCTOR -----------
  AppProvider(
    this._adminService,
    this._authService,
    this._constantsService,
    this._favorService,
    this._leaderboardService,
    this._postService,
    this._profileService,
    this._googleCalendarApiWrapper,
  );

  // ----------- METHODS -----------

  // ADMIN SERVICE METHODS
  Future<Statistics?> getStatistics(BuildContext context) async {
    return _adminService.getStatistics(context);
  }

  // AUTH SERVICE METHODS
  Future insertPersonalInfo({
    required context,
    required String gender,
    required String age,
    required String city,
    required String job,
    required String bio,
  }) async {
    return _authService.insertPersonalInfo(
      context: context,
      gender: gender,
      age: age,
      city: city,
      job: job,
      bio: bio,
    );
  }

  Future<void> signup({
    required BuildContext context,
    required String name,
    required String surname,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    return _authService.signup(
      context: context,
      name: name,
      surname: surname,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  Future<void> signin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    return _authService.signin(
      context: context,
      email: email,
      password: password,
    );
  }

  Future googleSignIn({required BuildContext context}) async {
    return _authService.googleSignIn(context: context);
  }

  void signout({required BuildContext context}) async {
    return _authService.signout(context: context);
  }

  // CONSTANTS SERVICE METHODS
  Future<ProfileConstants> getProfileConstants() async {
    return _constantsService.getProfileConstants();
  }

  Future<FavorCategories> getFavorCategories() async {
    return _constantsService.getFavorCategories();
  }

  Future<FavorConstants> getFavorConstants() async {
    return _constantsService.getFavorConstants();
  }

  // FAVOR SERVICE METHODS
  Future<List<BookedFavor>> getBookedFavors(
      BuildContext context, int pageNumber) async {
    return _favorService.getBookedFavors(context, pageNumber);
  }

  Future<bool> hasUserBookedSomeFavors(BuildContext context) async {
    return _favorService.hasUserBookedSomeFavors(context);
  }

  Future<bool> markFavorAsCompleted(
      BuildContext context, String bookedFavorId) async {
    return _favorService.markFavorAsCompleted(context, bookedFavorId);
  }

  Future<void> rateFavor(
      BuildContext context, String bookedFavorId, double rating) async {
    return _favorService.rateFavor(context, bookedFavorId, rating);
  }

  // LEADERBOARD SERVICE METHODS
  Future<Leaderboard?> getLeaderboard({
    required BuildContext context,
    required String? userType,
    required String? location,
  }) async {
    return _leaderboardService.getLeaderboard(
      context: context,
      userType: userType,
      location: location,
    );
  }

  Future<void> publishProviderFavor(
      {required BuildContext context,
      required String taskCategory,
      required String location,
      required availabilityStartTime,
      required availabilityEndTime,
      required description}) async {
    return _postService.publishProviderFavor(
      context: context,
      taskCategory: taskCategory,
      location: location,
      availabilityStartTime: availabilityStartTime,
      availabilityEndTime: availabilityEndTime,
      description: description,
    );
  }

  Future<void> publishCallerFavor(
      {required BuildContext context,
      required String taskCategory,
      required String location,
      required favorStartTime,
      required description}) async {
    return _postService.publishCallerFavor(
      context: context,
      taskCategory: taskCategory,
      location: location,
      favorStartTime: favorStartTime,
      description: description,
    );
  }

  Future<List<Post>> getPosts(BuildContext context, int pageNumber) async {
    return _postService.getPosts(
      context,
      pageNumber,
    );
  }

  Future<List<Post>> getPostsBySearch(
      {required BuildContext context,
      required String searchQuery,
      required String userTypeToSearch}) async {
    return _postService.getPostsBySearch(
      context: context,
      searchQuery: searchQuery,
      userTypeToSearch: userTypeToSearch,
    );
  }

  Future<void> bookFavor(
      {required BuildContext context,
      required Post? post,
      required String userType}) async {
    return _postService.bookFavor(
      context: context,
      post: post,
      userType: userType,
    );
  }

  // PROFILE SERVICE METHODS
  Future<User?> getMyUserProfile(BuildContext context) async {
    return _profileService.getMyUserProfile(context);
  }

  Future<User?> getUserProfileById(BuildContext context, String id) async {
    return _profileService.getUserProfileById(context, id);
  }

  // GOOGLE CALENDAR API WRAPPER METHODS
  Future insertEventInGoogleCalendar(BuildContext context, String eventName,
      String eventDescription, DateTime startTime) async {
    _googleCalendarApiWrapper.insertEventInGoogleCalendar(
      context,
      eventName,
      eventDescription,
      startTime,
    );
  }
}
