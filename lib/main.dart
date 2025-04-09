import 'package:flutter/material.dart';

void main() {
  runApp(AntistressApp());
}

class AntistressApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Mainbody(),
      ),
    );
  }
}


class Mainbody extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Mainbody();
  }
}

class _Mainbody extends State<Mainbody>{
  @override
  Widget build(BuildContext context) {
      return Text('mainbody');
  }
}