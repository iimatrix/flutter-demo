import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FadeApp extends StatefulWidget {
  // final String title;

  @override
  _FadeAppState createState() => _FadeAppState();
}

class _FadeAppState extends State<FadeApp> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: Container(
            width: 200,
            height: 200,
            color: Colors.green,
          ),
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                _visible = !_visible;
              });
            },
            child: Center(child:Icon(Icons.play_arrow))),
      ],
    );
  }
}
