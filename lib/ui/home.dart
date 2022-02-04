
import 'package:flutter/material.dart';
import 'package:flutter_gen_utils_web/ui/json_to_dart_serialization.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home' ;
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Home Page'),
              TextButton(
                child: Text('Json to Dart Serialization', textScaleFactor: 2,),
                onPressed: (){
                  debugPrint('Json To Dart serialization clicked');
                  Navigator.pushNamed(context, JsonToDartSerialization.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
