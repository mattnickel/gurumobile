class SocialPostList {
  final List<SocialPost> socialPosts;

  SocialPostList({
    this.socialPosts,
  });

  factory SocialPostList.fromJson(List<dynamic> parsedJson) {

    List<SocialPost> socialPosts = new List<SocialPost>();
    socialPosts = parsedJson.map((i)=>SocialPost.fromJson(i)).toList();

    return new SocialPostList(
        socialPosts: socialPosts
    );
  }
}

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

  SocialPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    message = json['message'];
    image = json['image'];
    userName = json['user_name'];
    userTagline = json['user_tagline'];
    userAvatar = json['user_avatar'];
    bumpCount = json['bump_count'];
    myBump = json ['my_bump'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time'] = this.time;
    data['message'] = this.message;
    data['image'] = this.image;
    data['user_name'] = this.userName;
    data['user_tagline'] = this.userTagline;
    data['user_avatar'] = this.userAvatar;
    data['bump_count'] = this.bumpCount;
    data['my_bump'] = this.myBump;
    return data;
  }
}