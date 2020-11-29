import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JsonApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchPhotos(http.Client()),
        builder:  (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? PhotosList(photos: snapshot.data)
              : Center(child: CircularProgressIndicator());
        }
    );
  }
  // @override
  // _JsonAppState createState() => _JsonAppState();
}

class PhotosList extends StatelessWidget {
  final List<Photo> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2
        ),
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return Image.network(photos[index].thumbnailUrl);
        });
  }
}


List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get('https://jsonplaceholder.typicode.com/photos');
  // 将json 解析工作移交到后台 isolate
  return compute(parsePhotos, response.body);
}

class Photo {
  final int id;
  final int albumId;
  final String url;
  final String title;
  final String thumbnailUrl;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}
