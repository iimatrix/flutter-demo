import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../extensions.dart';

class WebSocketApp extends StatefulWidget {
  final String title = 'WebSocket Demo';
  final WebSocketChannel channel = IOWebSocketChannel.connect('ws://echo.websocket.org');


  @override
  _WebSocketAppState createState() => _WebSocketAppState();
}

class _WebSocketAppState extends State<WebSocketApp> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Form(
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send a message'),
            ),
          ),
          StreamBuilder(
            stream: widget.channel.stream,
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
              );
            },
          )
        ],
      ),
    ).addBtn(_sendMessage);
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      widget.channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }


}
