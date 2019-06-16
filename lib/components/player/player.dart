import 'dart:ui';
import 'dart:math';
import 'package:ooidash/box-game.dart';
import 'package:flame/sprite.dart';
import 'package:sensors/sensors.dart';
import 'package:ooidash/components/player/score.dart';
import 'dart:async';

class MyPlayer {
  final BoxGame game;
  Rect playerRect;
  Offset playerPosition;
  double playerSpriteIndex = 0;
  List<Sprite> frames;
  double playerRotation = 0;
  double speed;
  double playerWidth;
  double playerHeight;
  Score playerScore;
  int playerColumnIndex;

  MyPlayer(this.game) {
    playerWidth = game.tileSize * 1;
    playerHeight = game.tileSize * 1;
    playerRect = Rect.fromLTWH((game.screenSize.width / 2) - playerWidth / 2, 10,
        playerWidth, playerHeight);
    playerPosition = Offset(0, 0);
    frames = List<Sprite>();
    frames.add(Sprite('oldmanterry1.png'));
    frames.add(Sprite('oldmanterry2.png'));
    speed = game.tileSize * 2;
    playerScore = Score(game);
    playerColumnIndex = game.bins.length ~/ 2;
    listenToRotation();
  }

  void listenToRotation() async {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      playerRotation += event.y;
    });
  }

  void render(Canvas c) {
    frames[playerSpriteIndex.toInt()].renderRect(c, playerRect.inflate(2));
    playerScore.render(c);
  }

  void update(double t) {
    playerSpriteIndex += 5 * t;
    if (playerSpriteIndex >= frames.length) {
      playerSpriteIndex = 0;
    }
    playerRect = Rect.fromLTWH(game.bins[playerColumnIndex] - (playerWidth / 2), 10,
        playerWidth, playerHeight);
//    double stepDistance = playerRotation * t * speed;
//    if (playerRect.left + stepDistance <= 0) {
//      stepDistance = -playerRect.left;
//    }
//    if (playerRect.right + stepDistance >= game.screenSize.width) {
//      stepDistance = game.screenSize.width - playerRect.right;
//    }
//    Offset stepToTarget = Offset.fromDirection(0, stepDistance);
//    playerRect = playerRect.shift(stepToTarget);
    playerScore.update(t);
  }

  void updatePlayerIndex(int val) {
    if (playerColumnIndex + val < 0) {
      playerColumnIndex = 0;
    } else if (playerColumnIndex + val > game.bins.length - 1) {
      playerColumnIndex = game.bins.length - 1;
    } else {
      playerColumnIndex += val;
    }
  }
}
