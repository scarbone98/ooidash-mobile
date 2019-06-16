import 'dart:ui';
import 'package:ooidash/box-game.dart';
import 'package:flame/sprite.dart';
import 'package:ooidash/components/animated-object.dart';
import 'package:ooidash/global-vars.dart';
class Gem extends AnimatedObject {
  double get speed => (game.tileSize * GlobalVars.objectSpeed) + (game.currentScore.score/10);
  double get size => 1;
  double get refreshRate => 5;
  static double initSize = 1;
  Gem(BoxGame game, double x, double y) : super(game, x - (game.tileSize * initSize/2), -(game.tileSize * initSize) - 10) {
    objectRect = Rect.fromLTWH(x - (game.tileSize * size/2), y, game.tileSize * size, game.tileSize * size);
    objectSprites = List<Sprite>();
    for (int i = 0; i < 64; i += 16) {
      objectSprites.add(Sprite('diamond.png', x: i.roundToDouble(), width: 16));
    }
  }
}