
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/config/application.dart';
import 'package:flutter_demo_app/config/routes.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget{
  MyApp() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo App',
      onGenerateRoute: Application.router.generator,
    );
  }
}