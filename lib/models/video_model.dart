
class VideosList {
  final List<Video> videos;

  VideosList({
    this.videos,
  });

  factory VideosList.fromJson(List<dynamic> parsedJson) {

    List<Video> videos = new List<Video>();
    videos = parsedJson.map((i)=>Video.fromJson(i)).toList();

    return new VideosList(
        videos: videos
    );
  }
}

class Video {
  int id;
  String title;
  String author;
  String description;
  int vimeoId;
  int seconds;
  String url;
  String image;
  String socialImage;
  String file;

  Video(
      {this.id,
        this.title,
        this.author,
        this.description,
        this.vimeoId,
        this.seconds,
        this.url,
        this.image,
        this.socialImage,
        this.file});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    description = json['description'];
    vimeoId = json['vimeo_id'];
    seconds = json['seconds'];
    url = json['url'];
    image = json['image'];
    socialImage = json['social_image'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['author'] = this.author;
    data['description'] = this.description;
    data['vimeo_id'] = this.vimeoId;
    data['seconds'] = this.seconds;
    data['url'] = this.url;
    data['image'] = this.image;
    data['social_image']=this.socialImage;
    data['file'] = this.file;
    return data;
  }
}