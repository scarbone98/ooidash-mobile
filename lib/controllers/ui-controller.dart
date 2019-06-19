import 'dart:ui';
import 'package:ooidash/box-game.dart';
import 'package:ooidash/components/ui/button.dart';
import 'package:flutter/gestures.dart';
import 'package:ooidash/components/ui/retry-screen.dart';

class UIController {
  BoxGame game;
  RetryScreen retryScreen;
  UIController(this.game) {
    retryScreen = RetryScreen(game);
  }

  void render(Canvas c) {
    retryScreen.render(c);
  }

  void update(double t) {
    retryScreen.update(t);
  }

  void handleTap(TapDownDetails d) {
    retryScreen.handleTap(d);
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