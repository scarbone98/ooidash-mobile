import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/gestures.dart';

class UIElement {
  Rect elementRect;
  Sprite elementSprite;
  Function onPress;

  UIElement(Sprite sprite, Rect rect) {
    elementSprite = sprite;
    elementRect = rect;
  }

  void render(Canvas c) {
    elementSprite.renderRect(c, elementRect.inflate(2));
  }

  bool checkPressed(TapDownDetails d) {
    Offset tapPosition = d.globalPosition;
    return (tapPosition.dx >= elementRect.left &&
        tapPosition.dx <= elementRect.right) &&
        (tapPosition.dy >= elementRect.top &&
            tapPosition.dy <= elementRect.bottom);
  }
}