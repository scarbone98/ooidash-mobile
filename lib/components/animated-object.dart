import 'dart:ui';
import 'package:ooidash/box-game.dart';
import 'package:flame/sprite.dart';

class AnimatedObject {
  final BoxGame game;
  List<Sprite> objectSprites;
  Offset objectLocation;
  bool isOffscreen = false;
  Rect objectRect;
  double objectSpriteIndex = 0;

  AnimatedObject(this.game, double x, double y) {
    objectLocation = Offset(x, y);
  }

  void render(Canvas c) {
    objectSprites[objectSpriteIndex.toInt()]
        .renderRect(c, objectRect.inflate(2));
  }

  void update(double t) {
    if (objectRect.top <= -objectRect.height + 1) {
      isOffscreen = true;
    }
    objectSpriteIndex += refreshRate * t;
    if (objectSpriteIndex >= objectSprites.length) {
      objectSpriteIndex = 0;
    }
    double stepDistance = speed * t;
    Offset toTarget = objectLocation - Offset(objectRect.left, objectRect.top);
    Offset stepToTarget =
        Offset.fromDirection(toTarget.direction, stepDistance);
    objectRect = objectRect.shift(stepToTarget);
  }

  double get speed => game.tileSize * 2;
  double get size => 0.5;
  double get refreshRate => 30;
}
