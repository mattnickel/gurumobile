import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' show get;
import 'package:sidebar_animation/helpers/fix_rotation.dart';

class SocialIndexModel with ChangeNotifier{
  final picker = ImagePicker();
  int value= 0;
  String imageUrl;
  File imageFile;
  List libraryList;
  String caption;
  bool isLoading = false;
  bool imageExists = false;
  File convertedImageFile;

  convertImage(imageUrl) async{
    var response = await get(imageUrl);
    var dir = await getTemporaryDirectory();
    print("convert");
    final file = File(dir.path + "/image.jpg");
    file.writeAsBytesSync(response.bodyBytes);
    convertedImageFile = file;
  }

  void getImage() async {
    final image = await picker.getImage(source: ImageSource.gallery, maxHeight: 700, maxWidth: 700);
    if (image != null) {
      imageFile = await fixImageRotation(image.path);
      imageExists = true;
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
    imageExists = bool;
    notifyListeners();
    print(bool);
  }
  void cancelImage(){
    imageFile = null;
    imageUrl = null;
    imageExists = false;
    convertedImageFile =null;
    notifyListeners();
    print("false");
  }
}