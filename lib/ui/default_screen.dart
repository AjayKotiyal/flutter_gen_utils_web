import 'package:flutter/material.dart';

class DefaultScreen extends StatelessWidget {
  final String content ;

  DefaultScreen({this.content = "Error Page"});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Page Unavailable"), centerTitle: true),
        body: Container(
          child: Center(
            child: Text(content,
            style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.red), // todo: change color
            ),
          ),
        ),
      ),
    );
  }
}
