import 'dart:math';

import 'package:flutter/material.dart';
import '../widget/slider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var rTarget = _randomColor();
  var gTarget = _randomColor();
  var bTarget = _randomColor();

  var rGuess = 0.5;
  var gGuess = 0.5;
  var bGuess = 0.5;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  _buildColorBox(context,'Target color block', Color.fromARGB(255, rTarget, gTarget, bTarget)),
                  SizedBox(width: 16,),
                  _buildColorBox(context,'Guess color block', Color.fromARGB(255, (rGuess*255).toInt(), (255*gGuess).toInt(), (255*bGuess).toInt())),
                ],
              ),
            ),
            SizedBox(height: 16,),
            RaisedButton(
              child: Text("Hit me button"),
              onPressed: () {
                _showDialog(context);
              }),
            SizedBox(height: 16,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ColorSlider(guess: rGuess, color: Colors.red, updateValue: _updateValue,),
                ColorSlider(guess: gGuess, color: Colors.green, updateValue: _updateValue,),
                ColorSlider(guess: bGuess, color: Colors.blue, updateValue: _updateValue,),
              ],
            )
          ],
        ),
      )
    );
  }

  Widget _buildColorBox(BuildContext context, String title, Color color) {
    return Column(children: <Widget>[
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: color
        ),
        width: MediaQuery.of(context).size.width/2 - 16,
        height: 120,
      ),
      Text(title)
    ],);
  }

  void _updateValue(double guess, Color color) {
    setState(() {
      if (color == Colors.red) {
        rGuess = guess;
      } else if (color == Colors.blue) {
        bGuess = guess;
      } else if (color == Colors.green) {
        gGuess = guess;
      }
    });
  }

  void _resetGame() {
    setState(() {
      rTarget = _randomColor();
      gTarget = _randomColor();
      bTarget = _randomColor();
      rGuess = 0.5;
      gGuess = 0.5;
      bGuess = 0.5;
    });
  }

  static int _randomColor() {
    return Random().nextInt(255);
  }

  int _computeScore() {
    final rDiff = rGuess - (rTarget/255).toDouble();
    final gDiff = gGuess - (gTarget/255).toDouble();
    final bDiff = bGuess - (bTarget/255).toDouble();
    final diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff);
    return ((1.0 - diff) * 100).ceil();
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Your score'),
          content: Text('${_computeScore()}', style: TextStyle(fontSize: 30),),
          actions: <Widget>[
            FlatButton(child: Text("Ok"),
            onPressed: () {
              _resetGame();
              Navigator.of(context).pop();
            },)
          ],
        );
      }
    );
  }
}