import 'package:day2_red_eyes_mvp/page/presenter.dart';
import 'package:flutter/material.dart';
import 'page/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Red Eyes!',
      home: MyHomePage(title: 'Flutter Red Eyes', presenter: Presenter(),),
    );
  }
}
