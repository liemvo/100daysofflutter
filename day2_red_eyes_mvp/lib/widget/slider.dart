import 'package:flutter/material.dart';

class ColorSlider extends StatefulWidget {
  double guess;
  final Color color;
  final Function updateValue;

  ColorSlider({Key key, this.guess, this.color, this.updateValue}) : super(key: key);

  @override
  _ColorSliderState createState() => _ColorSliderState();
}

class _ColorSliderState extends State<ColorSlider> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Text('0', style: TextStyle(color: widget.color),),
            Flexible(
              flex: 1,
              child: Slider(
                activeColor: widget.color,
                value: widget.guess,
                min: 0.0,
                max: 1.0,
                onChanged: (newValue){
                  setState(() {
                    widget.updateValue(newValue, widget.color);
                  });
                },
              ),
            ),
            Text('255', style: TextStyle(color: widget.color),),
          ],
        ),
    );
  }
}