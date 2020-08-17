
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

  Video(
      {this.id,
        this.title,
        this.author,
        this.description,
        this.vimeoId,
        this.seconds,
        this.url});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    description = json['description'];
    vimeoId = json['vimeo_id'];
    seconds = json['seconds'];
    url = json['url'];
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
    return data;
  }
}