import 'dart:ui';
import 'package:ooidash/enums/game-enums.dart';
class GlobalVars {
  static bool canSpawnItem = false;
  static double objectSpeed = 2;
  static GameState gameState = GameState.Start;
  static double meteorSize = 2;
  static double gemSize = 1;
  static double cometSize = 2;
  static double tileSize = 16/9;
  static double marsSize = 2;
  static double moonSize = 1.5;
  static double earthSize = 2.5;
  static double offScreenTargetTop;
  static double offScreenTargetBottom;
  static double spacingBetweenEnemySpawns = 4;
  static double playerEndScore = 0;
}