import 'dart:ui';
import 'package:ooidash/box-game.dart';
import 'package:flame/sprite.dart';
import 'package:ooidash/components/animated-object.dart';
import 'package:ooidash/global-vars.dart';
import 'package:ooidash/components/helpers/layout-helpers.dart';

class Comet extends AnimatedObject {
  double get speed =>
      (game.tileSize * GlobalVars.objectSpeed) + (game.currentScore.score / 10);

  double get size => GlobalVars.cometSize;
  static double initSize = GlobalVars.cometSize;

  Comet(BoxGame game, double x, double y)
      : super(game, LayoutHelpers.getCenteredPos(x, initSize),
            GlobalVars.offScreenTargetTop) {
    objectRect = Rect.fromLTWH(
        LayoutHelpers.getCenteredPos(x, size),
        LayoutHelpers.getCenteredPos(y, size) + GlobalVars.offScreenTargetBottom,
        game.tileSize * size,
        game.tileSize * size);
    objectSprites = List<Sprite>();
    objectSprites.add(Sprite('comet.png'));
  }
}
