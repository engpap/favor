import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:project/models/callerPost.dart';
import 'package:project/models/post.dart';
import 'package:project/models/providerPost.dart';

/**bookedAt: { //not in body; generated from server as a ISO format string
        type: Date,
        default: new Date(),
    },
    providerId: { type: String, required: true },
    callerId:  { type: String, required: true },
    post: { type: Schema.Types.ObjectId, ref: 'Post' },
    isTerminated: { type: Boolean, default:false, required: true},
    */

class BookedFavor {
  final String id;
  final DateTime bookedAt;
  final String providerId;
  final String callerId;
  final Post post;

  BookedFavor({
    required this.id,
    required this.bookedAt,
    required this.providerId,
    required this.callerId,
    required this.post,
  });

  static BookedFavor customFromMap(Map<String, dynamic> json) {
    return BookedFavor(
      id: json['_id'],
      bookedAt: DateTime.parse(json['bookedAt']),
      providerId: json['providerId'],
      callerId: json['callerId'],
      post: Post.getUserTypeGivenJsonString(json['post']) == 'caller'
          ? CallerPost.fromJson(json['post'])
          : ProviderPost.fromJson(json['post']),
    );
  }

  factory BookedFavor.fromJson(Map<String, dynamic> source) =>
      customFromMap(source);
}
