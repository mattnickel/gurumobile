import 'dart:async';
import 'package:http/http.dart' as http;

import '../services/social_api.dart';

class SocialPost {
  int id;
  String time;
  String message;
  String image;
  String video;
  int postUserId;
  String username;
  String userTagline;
  String userAvatar;
  int bumpCount;
  String myBump;
  List<Comments> comments;
  String group;

  SocialPost(
      {this.id,
        this.time,
        this.message,
        this.image,
        this.video,
        this.postUserId,
        this.username,
        this.userTagline,
        this.userAvatar,
        this.bumpCount,
        this.myBump,
        this.comments,
        this.group
        });

  factory SocialPost.fromServerMap(Map json){
    List commentsList = new List<Comments>();
    if (json['comments'] != null) {
      json['comments'].forEach((v) {
        commentsList.add(new Comments.fromJson(v));
      });
    }

    return SocialPost(
      id: json['id'],
      time: json['time'],
      message: json['message'],
      image: json['image'],
      video:json['video'],
      postUserId: json['post_user_id'],
      username: json['username'],
      userTagline: json['user_tagline'],
      userAvatar:json['user_avatar'],
      bumpCount: json['bump_count'],
      myBump: json ['my_bump'],
      comments: commentsList,
      group: json['group']
    );
    }

  }

class Comments {
  int id;
  String body;
  String createdAt;
  String username;

  Comments(
      {this.id,
        this.body,
        this.createdAt,
        this.username});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    createdAt = json['created_at'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body'] = this.body;
    data['created_at'] = this.createdAt;
    data['username'] = this.username;
    return data;
  }
}
class SocialPostList {

  Stream<List<SocialPost>> stream;
  bool hasMore;
  bool _isLoading;
  List<Map> _data;
  StreamController<List<Map>> _controller;
  String _group;

  SocialPostList({group}){
    _group = group;
    _data = List<Map>();
    _controller = StreamController<List<Map>>.broadcast();
    _isLoading = false;
    stream = _controller.stream.map((List<Map> postsData){
      print("tasks");
      print(postsData);
      return postsData.map((Map postData){
        return SocialPost.fromServerMap(postData);
      }).toList();
    });
    hasMore = true;
    refresh();
  }
  Future<void> refresh(){
    int page = 1;
    return loadMore(page, clearCachedData: true);
  }

  Future<void>loadMore(page, {bool clearCachedData = false}){
    print("let's load");
    if(clearCachedData){
      _data =List<Map>();
      hasMore=true;
      print('clear');
    }
    if(_isLoading || !hasMore){
      print('nada');
      return Future.value();
    }
    _isLoading = true;
    return fetchSocial(http.Client(), page, _group) .then((postsData){
      _isLoading = false;
      print("we are here");
      print(_group);
      _data.addAll(postsData);
      hasMore = (postsData.length == 8);
      _controller.add(_data);

    });
  }
}
