import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: non_constant_identifier_names
Container ImageTiles(image, selected){
    return Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          border: selected ? Border.all(color: Color(0xFF09eebc), width: 3.0) : null,
          borderRadius: BorderRadius.circular(18.0),

        ),
        margin: const EdgeInsets.only(right:20.0),
        height:100,
        width: 100,
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(17.0),
          child:
          CachedNetworkImage(
            imageUrl: image,
            imageBuilder: (context, imageProvider) => Container(
              height: 100,
              width:100,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    ),
              ),
            ),
            placeholder: (context, url) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
            // Image.network(image,
            // height: 100,
            // width:100,
            // fit: BoxFit.cover)
        )
        );
  }


