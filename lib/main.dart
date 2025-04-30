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
  var staticSize=false;
  var STbtn="D";

  void clearCircles(){
    setState(() {
      circlesList.clear();
    });
  }

  void screenTap(TapDownDetails infoDetails){
    var x=infoDetails.localPosition.dx;
    var y=infoDetails.localPosition.dy;
    print(x);
    print(y);
    var newcolor=Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);
    var newCircle=Circle(position: infoDetails.localPosition, color: newcolor, circleSize: currentSize);
    if(STbtn == 'D'){
      if(increaseSize==true){
        currentSize+=3;
        if(currentSize>=100){
          currentSize = 100;
          increaseSize=false;
        }
      }
      else{
        currentSize-=3;
        if(currentSize<=5){
          currentSize = 5;
          increaseSize=true;
        }
      }
    }
    setState(() {
       circlesList.add(newCircle);
    });
   
  }

  void changeMode(){
    setState(() {
      if(STbtn == 'D'){
        STbtn = 'S';
      }
      else{
        STbtn = 'D';
      }
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
              ),
              Positioned(
                bottom: 60,
                right: 10,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(125, 102, 73, 230)),
                  onPressed: changeMode, 
                  child: Text(
                    '$STbtn',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                    )
                  )
                ),
            Positioned(
              top: 35,
              right: 8,
              child: ElevatedButton(
                onPressed: clearCircles, 
                child: Text('Clear all'),
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(151, 68, 225, 230)),
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
            Positioned(
              left: 3,
              bottom: 60,
              child: Slider(
                value: currentSize,
                min: 5,
                max: 100,
                onChanged: (size){
              setState(() {
                currentSize = size;
              });
              
             })
              ),
              
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