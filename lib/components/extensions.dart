import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension WidgetMethod on Widget {
  Widget addBtn(Function pressHandler, [String title, Icon icon=const Icon(Icons.play_arrow)]) {
    return Column(
      children: [
        Expanded(child: this),
        ElevatedButton(
            onPressed: pressHandler,
            child: icon,
        ),
        Text('${title ?? ''}')
      ],
    );
  }
}