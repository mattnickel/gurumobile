import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' show get;
import 'package:sidebar_animation/helpers/fix_rotation.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:thumbnails/thumbnails.dart';

class SocialIndexModel with ChangeNotifier{
  final picker = ImagePicker();
  int value= 0;
  String imageUrl;
  File mediaFile;
  List libraryList;
  String caption;
  bool isLoading = false;
  bool mediaExists = false;
  File convertedImageFile;
  bool isVideo = false;
  File videoImage;
  Uint8List thumbnail;

  convertImage(imageUrl) async{
    var response = await get(imageUrl);
    var dir = await getTemporaryDirectory();
    print("convert");
    final file = File(dir.path + "/image.jpg");
    file.writeAsBytesSync(response.bodyBytes);
    convertedImageFile = file;
  }
  Future makeThumbnail(videoPath) async {
    thumbnail = await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 400, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 225,
    );
    isVideo = true;
    videoImage = File.fromRawPath(thumbnail);
    mediaFile = File(videoPath);
    print("thumbnail ready");
  }


  void getImage() async {
    final image = await picker.getImage(source: ImageSource.gallery, maxHeight: 700, maxWidth: 700);
    if (image != null) {
      mediaFile = await fixImageRotation(image.path);
      mediaExists = true;
      notifyListeners();
    }
  }
  void createImage() async {
    final image = await picker.getImage(source: ImageSource.camera, maxHeight: 700, maxWidth: 700);
    if (image != null) {
      mediaFile = await fixImageRotation(image.path);
      mediaExists = true;
      notifyListeners();
    }
  }
  void getVideo() async {
    PickedFile video = await picker.getVideo(source: ImageSource.gallery, maxDuration: const Duration(seconds: 60));

    if (video != null) {
      print("getting thumbnail");
      await makeThumbnail(video.path);
      print("got it");
      mediaExists = true;
      isVideo = true;
      print("true");
      notifyListeners();
    }
  }
  void createVideo() async {
    PickedFile video = await picker.getVideo(source: ImageSource.camera, maxDuration: const Duration(seconds: 60));

    if (video != null) {
      mediaFile = await fixImageRotation(video.path);
      mediaExists = true;
      print("true");
      notifyListeners();
    }
  }

 getSavedLibrary() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedImages = prefs.getString("socialLibrary");
      if(savedImages != null) {
        libraryList = json.decode(savedImages);
        notifyListeners();
      }
  }

  void setLoading(bool){
    isLoading = bool;
    notifyListeners();
  }
  void setSocialCaption(text){
    caption = text;
    notifyListeners();
  }

  void setSocialIndex(val){
    value = val;
    notifyListeners();
  }
  void setSocialImage(string){
    imageUrl = string;
    convertImage(string);
    notifyListeners();
  }
  void setImageExists(bool){
    mediaExists = bool;
    notifyListeners();
    print(bool);
  }
  void cancelImage(){
    thumbnail = null;
    mediaFile = null;
    imageUrl = null;
    mediaExists = false;
    convertedImageFile =null;
    notifyListeners();
    print("false");
  }
}