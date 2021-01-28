import 'dart:async';
import 'package:http/http.dart' as http;

import '../services/social_api.dart';

class SocialPost {
  int id;
  String time;
  String message;
  String image;
  String userName;
  String userTagline;
  String userAvatar;
  int bumpCount;
  String myBump;

  SocialPost(
      {this.id,
        this.time,
        this.message,
        this.image,
        this.userName,
        this.userTagline,
        this.userAvatar,
        this.bumpCount,
        this.myBump});

  factory SocialPost.fromServerMap(Map json){
    return SocialPost(
      id: json['id'],
      time: json['time'],
      message: json['message'],
      image: json['image'],
      userName: json['user_name'],
      userTagline: json['user_tagline'],
      userAvatar:json['user_avatar'],
      bumpCount: json['bump_count'],
      myBump: json ['my_bump'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['time'] = this.time;
  //   data['message'] = this.message;
  //   data['image'] = this.image;
  //   data['user_name'] = this.userName;
  //   data['user_tagline'] = this.userTagline;
  //   data['user_avatar'] = this.userAvatar;
  //   data['bump_count'] = this.bumpCount;
  //   data['my_bump'] = this.myBump;
  //   return data;
  // }
}
class SocialPostList {

  Stream<List<SocialPost>> stream;
  bool hasMore;
  bool _isLoading;
  List<Map> _data;
  StreamController<List<Map>> _controller;
  // int page;

  SocialPostList(){
    _data = List<Map>();
    _controller = StreamController<List<Map>>.broadcast();
    _isLoading = false;
    stream = _controller.stream.map((List<Map> postsData){
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
    print(page);
    return fetchSocial(http.Client(), page).then((postsData){
      _isLoading = false;
      print("we are here");
      _data.addAll(postsData);
      hasMore = (postsData.length == 8);
      _controller.add(_data);

    });
  }


  // factory SocialPostList.fromJson(List<dynamic> parsedJson) {
  //
  //   List<SocialPost> socialPosts = new List<SocialPost>();
  //   socialPosts = parsedJson.map((i)=>SocialPost.fromJson(i)).toList();
  //
  //   return new SocialPostList(
  //       socialPosts: socialPosts
  //   );
  // }
}

