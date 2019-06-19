import 'dart:ui';
import 'package:ooidash/box-game.dart';
import 'package:flame/sprite.dart';
import 'package:ooidash/components/animated-object.dart';
import 'package:ooidash/global-vars.dart';
import 'package:ooidash/components/helpers/layout-helpers.dart';

class Gem extends AnimatedObject {
  double get speed =>
      (game.tileSize * GlobalVars.objectSpeed) + (game.currentScore.score / 10);

  double get size => GlobalVars.gemSize;

  double get refreshRate => 5;
  static double initSize = GlobalVars.gemSize;

  Gem(BoxGame game, double x, double y)
      : super(game, LayoutHelpers.getCenteredPos(x, GlobalVars.gemSize),
            GlobalVars.offScreenTargetTop) {
    objectRect = Rect.fromLTWH(
        LayoutHelpers.getCenteredPos(x, size),
        y + GlobalVars.offScreenTargetBottom,
        game.tileSize * size,
        game.tileSize * size);
    objectSprites = List<Sprite>();
    for (int i = 0; i < 64; i += 16) {
      objectSprites.add(Sprite('diamond.png', x: i.roundToDouble(), width: 16));
    }
  }
}
