import 'dart:math';

import 'home.dart';
import 'model.dart';

class IPresenter {
  set view(IView value){}
  void onHitmeClicked(){}
  void onOkClicked(){}
  void updateColor(double guess, SlideType type){}
  int computeScore(){ return 0;}
  Model model;
}

class Presenter implements IPresenter {
  IView _view;

  @override
  set view(IView view){
    _view = view;
  }

  @override
  int computeScore() {
    final rDiff = model.rGuess - colorDouble(model.rTarget);
    final gDiff = model.gGuess - colorDouble(model.gTarget);
    final bDiff = model.bGuess - colorDouble(model.bTarget);
    final diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff);
    return ((1.0 - diff) * 100).ceil();
  }

  @override
  void onHitmeClicked() {
    _view.showScoreDialog();
  }

  void _resetGame() {
    model.reset();
  }

  @override
  void updateColor(double guess, SlideType type) {
    switch(type){
      case SlideType.RSlide: {
        model.rGuess = guess;
      }
      break;
      case SlideType.GSlide: {
        model.gGuess = guess;
      }
      break;
      case SlideType.BSlide: {
        model.bGuess = guess;
      }
      break;
    }
  }

  @override
  void onOkClicked() {
    _resetGame();
    _view.closeDialog();
  }

  @override
  Model model = Model();
}

double colorDouble(int value) => (value/255).toDouble();

int colorInt(double value) => (value * 255).ceil();
