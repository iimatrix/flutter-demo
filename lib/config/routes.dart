import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/config/route_handlers.dart';

class Routes {
  static const String root = '/';
  static const String animation = '/animation';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
      handlerFunc: (_, __) => AlertDialog(title: Text('ROUTE WAS NOT FOUND!!!')),
    );

    router.define(root, handler: rootHandler);
  }
}