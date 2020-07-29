
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

class Video{
  final int id;
  final String title;
  final String author;
  final String videoUrl;

  Video({
    this.id,
    this.title,
    this.author,
    this.videoUrl,

  }) ;

  factory Video.fromJson(Map<String, dynamic> json){
    return Video(
      id: json['id'] as int,
      title: json['title'],
      author: json['author'],
      videoUrl: json['url'],
    );

  }

}