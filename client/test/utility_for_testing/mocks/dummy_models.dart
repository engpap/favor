import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:project/models/bookedFavor.dart';
import 'package:project/models/callerPost.dart';
import 'package:project/models/providerPost.dart';
import 'package:project/models/user.dart';
import 'package:project/providers/user_provider.dart';

User dummy_user = new User(
  id: "userId",
  name: "name",
  surname: "surname",
  profilePicture: MemoryImage(base64Decode(noProfilePicture64String)),
  email: "email@email.com",
  rankingPoints: 123,
  averageRatings: 4,
  token: "valid_token",
  gender: "Male",
  age: 22,
  city: "Milan",
  job: "Software Developer",
  bio: "bio",
);

User dummy_user_2 = new User(
  id: "userId2",
  name: "name",
  surname: "surname",
  profilePicture: MemoryImage(base64Decode(noProfilePicture64String)),
  email: "email@email.com",
  rankingPoints: 123,
  averageRatings: 4,
  token: "valid_token",
  gender: "Male",
  age: 30,
  city: "Milan",
  job: "Accountant",
  bio: "bio",
);

CallerPost dummy_caller_post = CallerPost(
    id: "callerPostId",
    creatorId: "userId1",
    name: "name",
    surname: "surname",
    email: "email@email.com",
    profilePicture: Image.memory(base64Decode(noProfilePicture64String)),
    createdAt: "2023-01-29T08:15:23.012Z",
    userType: "caller",
    taskCategory: "Outdoor Cleaning",
    location: "loreto",
    favorStartTime: DateTime.parse("2023-01-30T08:15:23.012Z"),
    description: "description",
    averageRatings: 4,
    rankingPosition: 1,
    rankingLocation: "loreto",
    bio: "bio");

ProviderPost dummy_provider_post = ProviderPost(
    id: "callerPostId",
    creatorId: "userId2",
    name: "name",
    surname: "surname",
    email: "email@email.com",
    profilePicture: Image.memory(base64Decode(noProfilePicture64String)),
    createdAt: "2023-01-29T08:15:23.012Z",
    userType: "caller",
    taskCategory: "Outdoor Cleaning",
    location: "loreto",
    availabilityStartTime: DateTime.parse("2023-01-30T08:15:23.012Z"),
    availabilityEndTime: DateTime.parse("2023-01-30T09:15:23.012Z"),
    description: "description",
    averageRatings: 4,
    rankingPosition: 1,
    rankingLocation: "loreto",
    bio: "bio");

BookedFavor dummy_bookedFavor1 = BookedFavor(
    id: "bookedFavor1",
    bookedAt: DateTime.parse("2023-01-30T10:15:23.012Z"),
    providerId: "userId1",
    callerId: "userId2",
    post: dummy_caller_post);

BookedFavor dummy_bookedFavor2 = BookedFavor(
    id: "bookedFavor2",
    bookedAt: DateTime.parse("2023-01-30T11:15:23.012Z"),
    providerId: "userId2",
    callerId: "userId1",
    post: dummy_provider_post);
