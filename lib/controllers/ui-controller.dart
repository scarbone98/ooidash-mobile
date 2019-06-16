import 'dart:ui';
import 'package:ooidash/box-game.dart';
import 'package:flame/sprite.dart';
import 'package:ooidash/components/ui/button.dart';
import 'package:flutter/gestures.dart';
import 'package:ooidash/global-vars.dart';
import 'package:ooidash/enums/game-enums.dart';

class UIController {
  BoxGame game;
  double screenWidth;
  double screenHeight;
  double tileSize;
  List<Button> buttons;

  UIController(this.game) {
    screenWidth = game.screenSize.width;
    screenHeight = game.screenSize.height;
    tileSize = game.tileSize;
    buttons = List<Button>();
    for (int i = 0; i < 1; i++) {
      buttons.add(
        Button(
            Sprite('Buttons.png', x: 1684, y: 2422, height: 190, width: 180),
            Rect.fromLTWH(screenWidth/2 - (tileSize * 1), screenHeight/2 - (game.tileSize * 1), game.tileSize * 2, game.tileSize * 2),
            () => GlobalVars.gameState = GameState.Playing
        )
      );
    }
  }

  void render(Canvas c) {
    buttons.forEach((Button b) => b.render(c));
  }

  void update(double t) {

  }

  void handleTap(TapDownDetails d) {
    buttons.forEach((b) {
      if(b.checkPressed(d)) {
        b.onPress();
      }
    });
  }

}

//Paragraph paragraphWidget;
//double score = 1;
//Score(this.game) {
//  ParagraphBuilder paragraph = new ParagraphBuilder(new ParagraphStyle());
//  paragraph.pushStyle(new TextStyle(color: new Color(0xFFFFFFFF), fontSize: 48.0));
//  paragraph.addText(score.toString());
//  paragraphWidget = paragraph.build()..layout(new ParagraphConstraints(width: game.screenSize.width/2));
//}
//
//void render(Canvas c) {
//  c.drawParagraph(paragraphWidget, new Offset(this.game.screenSize.width/2 - paragraphWidget.width, this.game.screenSize.height - paragraphWidget.height - 10));
//}