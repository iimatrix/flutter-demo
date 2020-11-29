import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../extensions.dart';

class FileApp extends StatefulWidget {
  @override
  _FileAppState createState() => _FileAppState();
}

class _FileAppState extends State<FileApp> {
  final CounterStorage _storage = CounterStorage();
  int _counter;


  @override
  void initState() {
    super.initState();
    _storage.readCounter().then((value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _incrementCounter() {
    setState(() {
      _counter++;
    });
    return _storage.writeCounter(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(
      'Button tapped $_counter time${_counter == 1 ? '' : 's'}.',
    )).addBtn(_incrementCounter);
  }
}

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      String contents = await file.readAsString();
      return int.parse(contents);
    } catch (e) {
      return 0;
    }
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    return file.writeAsString('$counter');
  }
}