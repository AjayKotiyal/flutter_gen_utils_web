import 'package:flutter/material.dart';
import 'package:flutter_gen_utils_web/routes/route_generator.dart';
import 'package:flutter_gen_utils_web/ui/default_screen.dart';
import 'package:flutter_gen_utils_web/ui/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Utilities',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Home.routeName,
      routes: RouteGenerator.routeMap,
      onGenerateRoute: RouteGenerator.generateRoute,
      onUnknownRoute: (RouteSettings routeSettings) => MaterialPageRoute(
          builder: (context) => DefaultScreen(content: 'Unknown Route')),
    );
  }
}

