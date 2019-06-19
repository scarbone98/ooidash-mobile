import 'dart:ui';
import 'package:ooidash/box-game.dart';
import 'package:flame/sprite.dart';
import 'package:ooidash/components/player/score.dart';
import 'package:flutter_statusbar/flutter_statusbar.dart';
import 'package:ooidash/enums/game-enums.dart';

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
  double playerTopPadding;
  PlayerState playerState;
  double playerItemTimer;

  MyPlayer(this.game) {
    playerWidth = game.tileSize * 1;
    playerHeight = game.tileSize * 1;
    playerRect =
        Rect.fromLTWH((game.screenSize.width / 2) - playerWidth / 2, 10,
            playerWidth, playerHeight);
    frames = List<Sprite>();
    frames.add(Sprite('oldmanterry1.png'));
    frames.add(Sprite('oldmanterry2.png'));
    speed = game.tileSize * 2;
    playerScore = Score(game);
    playerScore.score = 0;
    playerColumnIndex = game.bins.length ~/ 2;
    playerState = PlayerState.Regular;
    playerItemTimer = 0;
    initialize();
  }

  void initialize() async {
    playerTopPadding = await FlutterStatusbar.height;
  }

  void render(Canvas c) {
    frames[playerSpriteIndex.toInt()].renderRect(c, playerRect.inflate(2));
    playerScore.render(c);
  }

  void update(double t) {

    //PLAYER SPRITE FRAMES LOGIC
    playerSpriteIndex += 5 * t;
    if (playerSpriteIndex >= frames.length) {
      playerSpriteIndex = 0;
    }

    // PLAYER ITEM LOGIC
    if (PlayerState.Sword == playerState) {
      playerItemTimer += t;
      if (playerItemTimer > 7) {
        playerItemTimer = 0;
        playerState = PlayerState.Regular;
      }
    }

    double padding;
    if (playerTopPadding != null) {
      padding = playerTopPadding;
    } else {
      padding = 10;
    }
    playerRect = Rect.fromLTWH(
        game.bins[playerColumnIndex] - (playerWidth / 2), padding,
        playerWidth, playerHeight);
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
