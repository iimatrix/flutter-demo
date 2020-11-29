import 'package:fluro/fluro.dart';
import 'package:flutter_demo_app/pages/root_component.dart';

var rootHandler = Handler(
  handlerFunc: (context, params) => Root(),
);