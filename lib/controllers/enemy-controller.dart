import 'dart:ui';
import 'package:ooidash/components/enemies/meteor.dart';
import 'package:ooidash/box-game.dart';
import 'package:ooidash/components/animated-object.dart';
import 'package:ooidash/global-vars.dart';
import 'package:ooidash/enums/game-enums.dart';
import 'package:ooidash/components/player/player.dart';
class EnemyController {
  BoxGame game;
  List<AnimatedObject> enemyObjects;
  MyPlayer player;

  EnemyController(this.game) {
    enemyObjects = List<AnimatedObject>();
    player = this.game.player;
  }

  void render(Canvas c) {
    enemyObjects.forEach((AnimatedObject object) => object.render(c));
  }

  void update(double t) {
    generateEnemies();
    enemyObjects.forEach((AnimatedObject object) {
      object.update(t);
      if (checkCrashed(player.playerRect, object.objectRect)) {
        GlobalVars.gameState = GameState.GameOver;
        print("GAME OVER");
      }
    });
    enemyObjects.removeWhere((AnimatedObject object) => object.isOffscreen);
  }


  void generateEnemies() {
    int numEnemiesToSpawn = (game.rnd.nextDouble() * 1).round() + 1;
    if (enemyObjects.isEmpty) {
      enemyObjects = enemyObjects
        ..addAll(createEnemiesArray(numEnemiesToSpawn));
      GlobalVars.canSpawnItem = true;
    } else {
      Rect lastEnemyObjectRect = enemyObjects.last.objectRect;
      if (lastEnemyObjectRect.bottom <=
          game.screenSize.height - lastEnemyObjectRect.height * 2) {
        enemyObjects = enemyObjects
          ..addAll(createEnemiesArray(numEnemiesToSpawn));
        GlobalVars.canSpawnItem = true;
      }
    }
  }

  List<AnimatedObject> createEnemiesArray(int numEnemies) {
    List<AnimatedObject> enemies = List<AnimatedObject>();
    for (int i = 0; i < numEnemies; i++) {
      enemies.add(Meteor(
          game,
          game.bins[(game.rnd.nextDouble() * (game.bins.length - 1)).round()],
          game.screenSize.height));
    }
    return enemies;
  }

  bool checkCrashed(Rect player, Rect object) {
    return (object.top <= player.bottom &&
        object.bottom - object.height / 2 > 0 &&
        object.left <= player.right &&
        object.right >= player.left);
  }

}