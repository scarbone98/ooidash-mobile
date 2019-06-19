import 'dart:ui';
import 'package:ooidash/components/ui/ui-sprite-element.dart';
import 'package:flame/sprite.dart';

class Button extends UIElement {
  Sprite sprite;
  Rect rect;
  Function onPress;
  Button(this.sprite, this.rect, this.onPress) : super(sprite,rect);
}