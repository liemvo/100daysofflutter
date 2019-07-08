import 'dart:math';

import 'package:day2_red_eyes_mvp/page/model.dart';
import 'package:day2_red_eyes_mvp/page/presenter.dart';
import 'package:flutter/material.dart';
import '../widget/slider.dart';

class IView {
  void showScoreDialog() {}
  void closeDialog() {}
}

class MyHomePage extends StatefulWidget{
  final String title;
  final IPresenter presenter;

  MyHomePage({Key key, this.title, this.presenter}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements IView {

  @override
  void initState() {
    this.widget.presenter.view = this;
    super.initState();
  }

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
                  _buildColorBox(
                    context,'Target color block', 
                    Color.fromARGB(255, widget.presenter.model.rTarget, widget.presenter.model.gTarget, widget.presenter.model.bTarget)),
                  SizedBox(width: 16,),
                  _buildColorBox(context,'Guess color block', Color.fromARGB(255, (widget.presenter.model.rGuess*255).toInt(), (255*widget.presenter.model.gGuess).toInt(), (255*widget.presenter.model.bGuess).toInt())),
                ],
              ),
            ),
            SizedBox(height: 16,),
            RaisedButton(
              child: Text("Hit me button"),
              onPressed: () {
                widget.presenter.onHitmeClicked();
              }),
            SizedBox(height: 16,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ColorSlider(guess: widget.presenter.model.rGuess, color: Colors.red, updateColor: _updateColore),
                ColorSlider(guess: widget.presenter.model.gGuess, color: Colors.green, updateColor: _updateColore),
                ColorSlider(guess: widget.presenter.model.bGuess, color: Colors.blue, updateColor: _updateColore),
              ],
            )
          ],
        ),
      )
    );
  }

  _updateColore(double value, SlideType slideType) {
    setState(() {
      widget.presenter.updateColor(value, slideType);
    });
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

  @override
  void showScoreDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Your score'),
          content: Text('${widget.presenter.computeScore()}', style: TextStyle(fontSize: 30),),
          actions: <Widget>[
            FlatButton(child: Text("Ok"),
            onPressed: () {
              setState(() {
                widget.presenter.onOkClicked();
              });
            },)
          ],
        );
      }
    );
  }

  @override
  void closeDialog() {
    Navigator.of(context).pop();
  }
}
