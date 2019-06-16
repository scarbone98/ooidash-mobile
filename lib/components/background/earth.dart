import 'dart:ui';
import 'package:ooidash/box-game.dart';
import 'package:flame/sprite.dart';
import 'package:ooidash/components/animated-object.dart';
class Earth extends AnimatedObject {
  double get speed => game.tileSize * 0.2;
  double get size => 2.5;
  double get refreshRate => 5;
  Earth(BoxGame game, double x, double y) : super(game, x, -(game.tileSize * 3) - 10) {
    objectRect = Rect.fromLTWH(x, y + 10, game.tileSize * size, game.tileSize * size);
    objectSprites = List<Sprite>();
    for (int i = 0; i < 128; i += 64) {
      objectSprites.add(Sprite('earth.png', x: i.roundToDouble(), width: 64));
    }
  }
}