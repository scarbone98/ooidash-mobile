import 'dart:ui';
import 'package:ooidash/components/enemies/meteor.dart';
import 'package:ooidash/box-game.dart';
import 'package:ooidash/components/animated-object.dart';
import 'package:ooidash/global-vars.dart';
import 'package:ooidash/enums/game-enums.dart';
import 'package:ooidash/components/player/player.dart';
import 'package:ooidash/components/enemies/comet.dart';
import 'package:ooidash/global-vars.dart';
import 'package:ooidash/enums/game-enums.dart';

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
        if (player.playerState == PlayerState.Regular) {
          GlobalVars.playerEndScore = game.player.playerScore.score;
          GlobalVars.gameState = GameState.GameOver;
        }
      }
    });
    enemyObjects.removeWhere((AnimatedObject object) => object.isOffscreen);
  }


  void generateEnemies() {
    double spacing = GlobalVars.spacingBetweenEnemySpawns;
    int numEnemiesToSpawn = game.rnd.nextInt(game.bins.length);
    if (numEnemiesToSpawn == 0) numEnemiesToSpawn = 1;
    if (enemyObjects.isEmpty) {
      enemyObjects = enemyObjects
        ..addAll(createEnemiesArray(numEnemiesToSpawn));
      GlobalVars.canSpawnItem = true;
    } else {
      Rect lastEnemyObjectRect = enemyObjects.last.objectRect;
      if (lastEnemyObjectRect.top <=
          game.screenSize.height + GlobalVars.offScreenTargetBottom - lastEnemyObjectRect.height * spacing) {
        enemyObjects = enemyObjects
          ..addAll(createEnemiesArray(numEnemiesToSpawn));
        GlobalVars.canSpawnItem = true;
      }
    }
  }

  List<AnimatedObject> createEnemiesArray(int numEnemies) {
    List<AnimatedObject> enemies = List<AnimatedObject>();
    List<double> binsClone = List<double>()..addAll(game.bins);
    for (int i = 0; i < numEnemies; i++) {
      int randomInt = game.rnd.nextInt(binsClone.length);
      if (game.player.playerScore.score > 2000) {
        enemies.add(
            Comet(
            game,
            binsClone[randomInt],
            game.screenSize.height)
        );
      } else {
        enemies.add(
            Meteor(
            game,
            binsClone[randomInt],
            game.screenSize.height)
        );
      }
      binsClone.removeAt(randomInt);
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