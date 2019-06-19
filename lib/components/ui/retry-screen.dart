import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'ui-sprite-element.dart';
import 'package:ooidash/components/ui/button.dart';
import 'package:ooidash/box-game.dart';
import 'package:ooidash/global-vars.dart';
import 'package:ooidash/enums/game-enums.dart';
import 'package:flame/sprite.dart';

class RetryScreen {
  BoxGame game;
  List<UIElement> elements;
  double screenWidth;
  double screenHeight;
  double tileSize;
  Paragraph scoreWidget;
  Paragraph scoreValue;

  RetryScreen(this.game) {
    elements = List<UIElement>();
    screenHeight = game.screenSize.height;
    screenWidth = game.screenSize.width;
    tileSize = game.tileSize;
    scoreWidget = createUIText(text: 'score', width: tileSize * 4);
    scoreValue = createUIText(
        text: GlobalVars.playerEndScore.toInt().toString(),
        width: tileSize * 4);
    buildScreen();
  }

  void buildScreen() {
    elements.add(UIElement(
        Sprite('windows.png', x: 3550, y: 0, height: 390, width: 780),
        Rect.fromLTWH(tileSize/2, tileSize, tileSize * 8, tileSize * 4)));
    elements.add(Button(
        Sprite('buttons.png', x: 1684, y: 2422, height: 190, width: 180),
        Rect.fromLTWH(
            screenWidth / 2 - (tileSize * 1),
            screenHeight / 2 - (game.tileSize * 1),
            game.tileSize * 2,
            game.tileSize * 2),
        () => GlobalVars.gameState = GameState.Playing));
  }

  void render(Canvas c) {
    elements.forEach((element) => element.render(c));
    c.drawParagraph(scoreWidget,
        new Offset((tileSize * 4.5) - scoreWidget.width / 2, tileSize));
    c.drawParagraph(
        scoreValue, new Offset((tileSize * 4.5) - scoreWidget.width/2, tileSize * 3));
  }

  void update(double t) {
    scoreValue = createUIText(
        text: GlobalVars.playerEndScore.toInt().toString(),
        width: tileSize * 4
    );
  }

  void handleTap(TapDownDetails d) {
    elements.forEach((b) {
      if (b.checkPressed(d) && b.onPress != null) {
        b.onPress();
      }
    });
  }

  Paragraph createUIText({String text, double width}) {
    ParagraphBuilder paragraph =
        new ParagraphBuilder(new ParagraphStyle(textAlign: TextAlign.center));
    paragraph
        .pushStyle(new TextStyle(color: new Color(0xFF000000), fontSize: 48.0));
    paragraph.addText(text);
    return paragraph.build()..layout(new ParagraphConstraints(width: width));
  }
}
