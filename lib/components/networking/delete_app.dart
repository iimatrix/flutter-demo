import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../extensions.dart';

class DeleteApp extends StatefulWidget {
  @override
  _DeleteAppState createState() => _DeleteAppState();
}

class _DeleteAppState extends State<DeleteApp> {
  Future<List<Album>> _data;
  int _count;
  String _title = 'delete';


  @override
  void initState() {
    super.initState();
    _data = fetchAlbum();
  }


  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _data.then((value) {
      setState(() {
        _count = value.length;
      });
    });
  }

  @override
  Widget build(BuildContext context)  {
    return FutureBuilder<List<Album>>(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListWheelScrollView(
                  itemExtent: 150,
                  children: snapshot.data.map((e) => Container(
                      width: MediaQuery.of(context).size.width,
                      color: e.id == 1 ? Colors.red : Colors.lightBlue,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text('${e.title}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),))),
                  ).toList(),
              );
            }
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return SizedBox(child: CircularProgressIndicator(), width: 10, height: 10);
        }
    ).addBtn(deleteAlbum, '$_title');
  }

  void deleteAlbum() async {
    final http.Response response = await http.delete('https://jsonplaceholder.typicode.com/albums/${100 -(_count ?? 1)}', headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      setState(() {
        _title = 'delete success';
      });
    }
  }
}

Future<List<Album>> fetchAlbum() async {
  final http.Response response = await http.get('https://jsonplaceholder.typicode.com/albums');
  if (response.statusCode == 200) {
    return jsonDecode(response.body).cast<Map<String, dynamic>>().map<Album>((ele) => Album.fromJson(ele)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  final int id;
  final String title;

  Album({this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}
