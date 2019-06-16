import 'dart:ui';
import 'package:ooidash/box-game.dart';
import 'package:ooidash/components/background/earth.dart';
import 'package:ooidash/components/background/mars.dart';
import 'package:ooidash/components/background/moon.dart';
import 'package:ooidash/components/animated-object.dart';
import 'package:flame/sprite.dart';

class Background {
  final BoxGame game;
  List<AnimatedObject> backgroundObjects;
  Sprite mainBackground;
  double spawnScore;

  Background(this.game) {
    spawnScore = 500;
    mainBackground = Sprite('background.png');
    backgroundObjects = List<AnimatedObject>();
  }

  void render(Canvas canvas) {
    mainBackground.render(canvas);
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
        return Moon(
            game,
            (game.screenSize.width - (game.tileSize * 2.025)),
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
    if (game.currentScore.score > spawnScore) {
      backgroundObjects.add(createRandomBackgroundObject());
      spawnScore += 500 + spawnScore;
    }
    backgroundObjects.forEach((AnimatedObject object) => object.update(t));
    backgroundObjects
        .removeWhere((AnimatedObject object) => object.isOffscreen);
  }
}
