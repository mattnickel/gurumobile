import 'dart:io';
import 'package:exif/exif.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;

fixImageRotation(imagePath) async{
  final img.Image capturedImage = img.decodeImage(await File(imagePath).readAsBytes());
  final img.Image orientedImage = img.bakeOrientation(capturedImage);
  return await File(imagePath).writeAsBytes(img.encodeJpg(orientedImage));
}