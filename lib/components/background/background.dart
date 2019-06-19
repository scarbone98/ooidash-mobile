import 'dart:ui';
import 'package:ooidash/box-game.dart';
import 'package:ooidash/components/background/earth.dart';
import 'package:ooidash/components/background/mars.dart';
import 'package:ooidash/components/background/moon.dart';
import 'package:ooidash/components/animated-object.dart';
import 'package:flame/sprite.dart';
import 'package:flame/position.dart';
import 'package:ooidash/global-vars.dart';
import 'package:ooidash/enums/game-enums.dart';

class Background {
  final BoxGame game;
  List<AnimatedObject> backgroundObjects;
  Sprite mainBackground1;
  Sprite mainBackground2;
  double spawnScore;
  double mainBackgroundYPos1;
  double mainBackgroundYPos2;
  double yBackgroundSpeed = 0;
  int mainBackgroundHeight;

  Background(this.game) {
    spawnScore = 500;
    mainBackground1 = Sprite('background.png');
    mainBackground2 = Sprite('background.png');
    mainBackgroundHeight = 1079;
    mainBackgroundYPos1 = 0;
    mainBackgroundYPos2 = mainBackgroundHeight.toDouble();
    backgroundObjects = List<AnimatedObject>();
  }

  void render(Canvas canvas) {
    mainBackground1.renderPosition(canvas, Position(0, mainBackgroundYPos1));
    mainBackground2.renderPosition(canvas, Position(0, mainBackgroundYPos2));
    backgroundObjects.forEach((AnimatedObject object) => object.render(canvas));
  }

  AnimatedObject createRandomBackgroundObject() {
    switch (game.rnd.nextInt(3)) {
      case 1:
        return Earth(
            game,
            game.rnd.nextDouble() *
                (game.screenSize.width - (game.tileSize * 2.025)),
            game.screenSize.height);
      case 2:
        return Mars(game, (game.screenSize.width - (game.tileSize * 2.025)),
            game.screenSize.height);
      case 3:
        return Moon(game, (game.screenSize.width - (game.tileSize * 2.025)),
            game.screenSize.height);
      default:
        return Earth(
            game,
            game.rnd.nextDouble() *
                (game.screenSize.width - (game.tileSize * 2.025)),
            game.screenSize.height);
    }
  }

  void update(double t) {
    yBackgroundSpeed += t;
    mainBackgroundYPos1--;
    mainBackgroundYPos2--;
    if (mainBackgroundYPos1 <= -mainBackgroundHeight) {
      mainBackgroundYPos1 = mainBackgroundHeight.toDouble();
    }
    if (mainBackgroundYPos2 <= -mainBackgroundHeight) {
      mainBackgroundYPos2 = mainBackgroundHeight.toDouble();
    }
    if (game.currentScore.score > spawnScore) {
      backgroundObjects.add(createRandomBackgroundObject());
      spawnScore += 500 + spawnScore;
    }
    backgroundObjects.forEach((AnimatedObject object) => object.update(t));
    backgroundObjects
        .removeWhere((AnimatedObject object) => object.isOffscreen);
  }
}
