import 'dart:math';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:ooidash/components/player/player.dart';
import 'package:ooidash/components/background/background.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:ooidash/components/player/score.dart';
import 'package:ooidash/controllers/enemy-controller.dart';
import 'package:ooidash/controllers/item-controller.dart';
import 'package:ooidash/enums/game-enums.dart';
import 'package:ooidash/global-vars.dart';

class BoxGame extends Game {
  Size screenSize;
  double tileSize;
  MyPlayer player;
  List<double> bins;
  Random rnd = Random();
  Background background;
  static AudioCache audioCache = AudioCache();
  Score currentScore;

  EnemyController enemyController;
  ItemController itemController;

  BoxGame() {
    initialize();
  }

  void initialize() async {
//    audioCache.loop('audio/ooidashtheme2.mp3');
    resize(await Flame.util.initialDimensions());
    bins = createBins(3);
    player = MyPlayer(this);
    currentScore = player.playerScore;
    enemyController = EnemyController(this);
    itemController = ItemController(this);
    background = Background(this);
  }

  List<double> createBins(numBins) {
    double screenWidth = screenSize.width;
    double stepSize = screenWidth / numBins;
    List<double> bins = List<double>();
    for (int i = 0; i < screenWidth.toInt(); i += stepSize.toInt()) {
      bins.add(i + stepSize / 2);
    }
    double remaining = screenSize.width - bins.last;
    double offSetFix = (remaining + bins.first) / 2;
    bins.first = offSetFix;
    bins.last = screenSize.width - offSetFix;
    return bins;
  }

  void render(Canvas canvas) {
    background.render(canvas);
    switch (GlobalVars.gameState) {
      case GameState.InMenu:
        break;
      case GameState.Playing:
        enemyController.render(canvas);
        itemController.render(canvas);
        player.render(canvas);
        break;
      case GameState.GameOver:
        initialize();
        GlobalVars.gameState = GameState.Playing;
        break;
    }
  }

  void update(double t) {
    switch (GlobalVars.gameState) {
      case GameState.InMenu:
        break;
      case GameState.Playing:
        player.update(t);
        enemyController.update(t);
        itemController.update(t);
        background.update(t);
        break;
      case GameState.GameOver:
        break;
    }
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = size.width / 9.0;
    super.resize(size);
  }

  void onTapDown(TapDownDetails d) {
    double tapXCoord = d.globalPosition.dx;
    if (tapXCoord < screenSize.width / 2) {
      player.updatePlayerIndex(-1);
    } else {
      player.updatePlayerIndex(1);
    }
  }
}