import 'dart:math';

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

  List<Circle>circlesList=[];
  double currentSize = 5;
  var increaseSize=true;



  void screenTap(TapDownDetails infoDetails){
    var x=infoDetails.localPosition.dx;
    var y=infoDetails.localPosition.dy;
    print(x);
    print(y);
    var newcolor=Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);
    var newCircle=Circle(position: infoDetails.localPosition, color: newcolor, circleSize: currentSize);
    if(increaseSize==true){
      currentSize+=3;
      if(currentSize>100){
        increaseSize=false;
      }
    }
    else{
      currentSize-=3;
      if(currentSize<5){
        increaseSize=true;
      }
    }
    setState(() {
       circlesList.add(newCircle);
    });
   
  }

  @override
  Widget build(BuildContext context) {
      return GestureDetector(
        onTapDown:screenTap,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            Positioned(
              top: 3,
              right: 3,
              child: ElevatedButton(
                onPressed: (){}, 
                child: Text('Clear all'),
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 68, 224, 230)),
                )),
            Center(
                child: Text(
                  'Tap anywhere', 
                  style: TextStyle(
                    color: const Color.fromARGB(255, 60, 185, 165),
                    fontSize: 20
                    ),
                  ),
                ),
                ...circlesList.map((eachCircle)=>Positioned(
                  left: eachCircle.position.dx - eachCircle.circleSize/2,
                  top: eachCircle.position.dy - eachCircle.circleSize/2,
                  child: Container(
                    width: eachCircle.circleSize,
                    height: eachCircle.circleSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: eachCircle.color
                    ),
                  )
                )
              )
          ],

          
        )
      );
  }
}

class Circle{
  final Offset position;
  final Color color;
  final double circleSize;
  Circle ({required this.position, required this.color, required this.circleSize});
}