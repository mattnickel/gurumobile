class VideoCategoryList {
  final List<VideoCategory> videoCategories;

  VideoCategoryList({
    this.videoCategories,
  });

  factory VideoCategoryList.fromJson(List<dynamic> parsedJson) {

    List<VideoCategory> videoCategories = new List<VideoCategory>();
    videoCategories = parsedJson.map((i)=>VideoCategory.fromJson(i)).toList();

    return new VideoCategoryList(
        videoCategories: videoCategories
    );

  }

}



class VideoCategory {
  String name;

  VideoCategory({this.name});

  VideoCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}