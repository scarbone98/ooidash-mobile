import 'dart:ui';
import 'package:ooidash/box-game.dart';
import 'package:flame/sprite.dart';
import 'package:ooidash/components/animated-object.dart';
import 'package:ooidash/global-vars.dart';
class Meteor extends AnimatedObject {
  double get speed => (game.tileSize * GlobalVars.objectSpeed) + (game.currentScore.score/10);
  double get size => 2;
  static double initSize = 2;
  Meteor(BoxGame game, double x, double y) : super(game, x - (game.tileSize * initSize/2), -(game.tileSize * initSize) - 10) {
    objectRect = Rect.fromLTWH(x - (game.tileSize * size/2), y + (game.tileSize * size/2), game.tileSize * size, game.tileSize * size);
    objectSprites = List<Sprite>();
    objectSprites.add(Sprite('meteor.png'));
  }

}