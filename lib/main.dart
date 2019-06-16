import 'package:ooidash/box-game.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
void main() async {
  Util flameUtil = Util();
  await Flame.audio.loadAll([
    'ooidashtheme2.mp3'
  ]);
  await Flame.images.loadAll([
    'background.png',
    'oldmanterry1.png',
    'oldmanterry2.png',
    'earth.png',
    'mars.png',
    'moon.png',
    'background.png',
    'diamond.png',
    'Buttons.png'
  ]);
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  BoxGame game = BoxGame();
  runApp(game.widget);
  TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer();
  tapGestureRecognizer.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapGestureRecognizer);
}
