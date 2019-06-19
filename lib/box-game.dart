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
import 'package:ooidash/controllers/ui-controller.dart';
import 'package:ooidash/enums/game-enums.dart';
import 'package:ooidash/global-vars.dart';
import 'ai.dart';
import 'singleton.dart';
import 'ui-manager.dart';

class BoxGame extends Game {
  Size screenSize;
  double tileSize;
  MyPlayer player;
  List<double> bins;
  Random rnd = Random();
  Background background;
  static AudioCache audioCache;
  Score currentScore;
  static Score uiScore;
  EnemyController enemyController;
  ItemController itemController;
//  UIController uiController;
  AI ai;
  UIManagerState uiManagerState;

  BoxGame() {
    uiManagerState = Singleton.uiManager.state;
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    initGameVariables();
//    uiController = UIController(this);
    background = Background(this);
  }

  void initGameVariables() {
//    audioCache = AudioCache();
//    audioCache.loop('audio/ooidashtheme2.mp3');
    ai = AI(this);
    bins = createBins(3);
    player = MyPlayer(this);
    currentScore = player.playerScore;
    uiScore = currentScore;
    enemyController = EnemyController(this);
    itemController = ItemController(this);
  }

  List<double> createBins(numBins) {
    double screenWidth = screenSize.width;
    int stepSize = screenWidth ~/ numBins;
    List<double> bins = List<double>();
    for (int i = 0; i < screenWidth.toInt(); i += stepSize) {
      if (bins.length == numBins) break;
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
      case GameState.Start:
//        uiController.render(canvas);
        break;
      case GameState.Playing:
        enemyController.render(canvas);
        itemController.render(canvas);
        player.render(canvas);
        break;
      case GameState.GameOver:
        break;
    }
  }

  void update(double t) {
    background.update(t);
    switch (GlobalVars.gameState) {
      case GameState.Start:
//        uiController.update(t);
        break;
      case GameState.Playing:
//        ai.reactionTimeCurrent += t;
//        if (ai.reactionTimeCurrent >= ai.reactionRime) {
//          ai.updatePlayerMove();
//          ai.reactionTimeCurrent = 0;
//        }
        if (uiManagerState.currentScreen != UIScreens.playing) {
          uiManagerState.currentScreen = UIScreens.playing;
          uiManagerState.update();
        }
        player.update(t);
        itemController.update(t);
        enemyController.update(t);
        break;
      case GameState.GameOver:
        if (uiManagerState.currentScreen != UIScreens.gameOver) {
          uiManagerState.score = player.playerScore.score.toInt().toString();
          uiManagerState.currentScreen = UIScreens.gameOver;
          uiManagerState.update();
          print('GAME OVER');
        }
        initGameVariables();
//        GlobalVars.gameState = GameState.InMenu;
        break;
    }
  }

  void resize(Size size) {
    screenSize = size;
    GlobalVars.offScreenTargetTop = -(size.height * 0.3);
    GlobalVars.offScreenTargetBottom = (size.height * 0.3);
    tileSize = size.width / 9.0;
    GlobalVars.tileSize = tileSize;
    super.resize(size);
  }

  void onTapDown(TapDownDetails d) {
    switch (GlobalVars.gameState) {
      case GameState.Playing:
        double tapXCoord = d.globalPosition.dx;
        if (tapXCoord < screenSize.width / 2) {
          player.updatePlayerIndex(-1);
        } else {
          player.updatePlayerIndex(1);
        }
        break;
      case GameState.Start:
//        uiController.handleTap(d);
        break;
      case GameState.GameOver:
        break;
    }
  }
}
