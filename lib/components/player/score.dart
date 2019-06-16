import 'dart:ui';
import 'dart:math';
import 'package:ooidash/box-game.dart';


class Score {
  final BoxGame game;
  Paragraph paragraphWidget;
  double score = 1;
  Score(this.game) {
    ParagraphBuilder paragraph = new ParagraphBuilder(new ParagraphStyle());
    paragraph.pushStyle(new TextStyle(color: new Color(0xFFFFFFFF), fontSize: 48.0));
    paragraph.addText(score.toString());
    paragraphWidget = paragraph.build()..layout(new ParagraphConstraints(width: game.screenSize.width/2));
  }

  void render(Canvas c) {
    c.drawParagraph(paragraphWidget, new Offset(this.game.screenSize.width/2 - paragraphWidget.width, this.game.screenSize.height - paragraphWidget.height - 10));
  }

  void update(double t) {
//    0.0255
//    print(0xFFFFFFFF);
    score += t * 5;
    String redShadeValue = (score * 0.051).toInt().toRadixString(16);
    if (redShadeValue.length == 1) {
      redShadeValue = '0' + redShadeValue;
    }
    if (int.parse(redShadeValue, radix: 16) > 255) {
      redShadeValue = 'ff';
    }
    ParagraphBuilder paragraph = new ParagraphBuilder(new ParagraphStyle());
    paragraph.pushStyle(new TextStyle(color: Color(0xFF000000 + (0x00FF0000) + (0x0000FF00 - int.parse(redShadeValue + '00', radix: 16)) + (0x000000FF - int.parse(redShadeValue, radix: 16))), fontSize: 48.0));
    paragraph.addText(score.floor().toString());
    paragraphWidget = paragraph.build()..layout(new ParagraphConstraints(width: game.screenSize.width/2));
  }

  Color hexToColor(String code) {
    print(code);
    return new Color(int.parse(code.substring(2, 8), radix: 16) + 0xFF000000);
  }

}
