
class TrainingModulesList {
  final List<TrainingModule> trainingModules;

  TrainingModulesList({
    this.trainingModules,
  });

  factory TrainingModulesList.fromJson(List<dynamic> parsedJson) {

    List<TrainingModule> trainingModules = new List<TrainingModule>();
    trainingModules = parsedJson.map((i)=>TrainingModule.fromJson(i)).toList();

    return new TrainingModulesList(
        trainingModules: trainingModules
    );
  }
}

class TrainingModule {
  int id;
  String title;
  String description;
  String coverPhoto;
  List<Videos> videos;

  TrainingModule(
      {this.id, this.title, this.description, this.coverPhoto, this.videos});

  TrainingModule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    coverPhoto = json['cover_photo'];
    if (json['videos'] != null) {
      videos = new List<Videos>();
      json['videos'].forEach((v) {
        videos.add(new Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['cover_photo'] = this.coverPhoto;
    if (this.videos != null) {
      data['videos'] = this.videos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Videos {
int id;
String title;
String author;
String description;
int vimeoId;
int seconds;
String url;
String image;
String file;

Videos(
    {this.id,
      this.title,
      this.author,
      this.description,
      this.vimeoId,
      this.seconds,
      this.url,
      this.image,
      this.file});

Videos.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  title = json['title'];
  author = json['author'];
  description = json['description'];
  vimeoId = json['vimeo_id'];
  seconds = json['seconds'];
  url = json['url'];
  image = json['image'];
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
  data['file'] = this.file;
  return data;
  }
}

