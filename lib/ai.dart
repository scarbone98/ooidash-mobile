import 'box-game.dart';
import 'controllers/enemy-controller.dart';
import 'components/animated-object.dart';
import 'components/player/player.dart';
import 'dart:math';
class AI {
  BoxGame game;
  double reactionRime;
  double reactionTimeCurrent;
  AI(this.game) {
    reactionRime = 0;
    reactionTimeCurrent = 0;
  }

  void updatePlayerMove() {
    MyPlayer player = game.player;
    if (game.enemyController.enemyObjects.isEmpty) return;
    AnimatedObject topEnemy = game.enemyController.enemyObjects.first;
    List<AnimatedObject> enemies = game.enemyController.enemyObjects.where(
        (AnimatedObject o) =>
            o.objectRect.center.dy.toInt() ==
            topEnemy.objectRect.center.dy.toInt()).toList();
    List<double> binCopy = List<double>()..addAll(game.bins);
    for(AnimatedObject enemy in enemies) {
      int enemyColVal = enemy.objectRect.center.dx.toInt();
      for (int i = 0; i < binCopy.length; i++) {
        if((enemyColVal - binCopy[i].toInt()).abs() <= 10) {
          binCopy.removeAt(i);
        }
      }
    }
    int randInt = Random().nextInt(binCopy.length);
    int valueToMoveTo = binCopy[randInt].toInt();
    int startValue = player.playerRect.center.dx.toInt();
    bool alreadySafe = false;
    binCopy.forEach((double d) {
      if (d.toInt() == startValue) {
        alreadySafe = true;
      }
    });
    if (alreadySafe) return;
    while(startValue > valueToMoveTo) {
      player.updatePlayerIndex(-1);
      startValue = game.bins[player.playerColumnIndex].toInt();
    }
    while(startValue < valueToMoveTo) {
      player.updatePlayerIndex(1);
      startValue = game.bins[player.playerColumnIndex].toInt();
    }
  }
}
