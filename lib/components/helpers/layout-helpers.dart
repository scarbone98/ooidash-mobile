import 'package:ooidash/global-vars.dart';

class LayoutHelpers {
  static double getCenteredPos(double originalPos, double objectSize) {
    return originalPos - (GlobalVars.tileSize * objectSize/2);
  }
}