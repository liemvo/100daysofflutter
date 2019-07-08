import 'dart:math';

enum SlideType {
  RSlide, GSlide, BSlide
}

class Model {
  int _rTarget;
  int _gTarget;
  int _bTarget;

  int get rTarget => _rTarget;
  int get gTarget => _gTarget;
  int get bTarget => _bTarget;

  double _rGuess;
  double _gGuess;
  double _bGuess;

  double get rGuess => _rGuess;
  set rGuess(double value){
    _rGuess = value;
  }

  double get gGuess => _gGuess;
  set gGuess(double value){
    _gGuess = value;
  }

  double get bGuess => _bGuess;
  set bGuess(double value){
    _bGuess = value;
  }

  Model() {
    reset();
  }

  void reset() {
    _rTarget = _randomColor();
    _gTarget = _randomColor();
    _bTarget = _randomColor();

    _rGuess = 0.5;
    _gGuess = 0.5;
    _bGuess = 0.5;
  }
}

int _randomColor() {
    return Random().nextInt(255);
}
