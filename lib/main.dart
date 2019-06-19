import 'package:ooidash/box-game.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ooidash/ui-manager.dart';
import 'singleton.dart';
import 'package:flutter/gestures.dart';

void main() async {
  Util flameUtil = Util();
  await Flame.audio.loadAll(['ooidashtheme2.mp3']);
  await Flame.images.loadAll([
    'background.png',
    'oldmanterry1.png',
    'oldmanterry2.png',
    'earth.png',
    'mars.png',
    'moon.png',
    'background.png',
    'diamond.png',
    'buttons.png',
    'windows.png',
    'items.png'
  ]);
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  UIManager uiManager = Singleton.uiManager;
  BoxGame game = Singleton.gameInstance;
  runApp(MaterialApp(
      home: Scaffold(
          body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(
              child: game.widget
          ),
          Positioned.fill(child: uiManager)
        ],
      )),
      debugShowCheckedModeBanner: false));
  TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer();
  tapGestureRecognizer.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapGestureRecognizer);
}
