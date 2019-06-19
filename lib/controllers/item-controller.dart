import 'dart:ui';
import 'package:ooidash/components/items/gem.dart';
import 'package:ooidash/box-game.dart';
import 'package:ooidash/components/animated-object.dart';
import 'package:ooidash/global-vars.dart';
import 'package:ooidash/controllers/enemy-controller.dart';
import 'package:ooidash/components/items/sword.dart';
import 'package:ooidash/enums/game-enums.dart';

class ItemController {
  BoxGame game;
  List<AnimatedObject> itemObjects;
  EnemyController enemyController;

  ItemController(this.game) {
    itemObjects = List<AnimatedObject>();
    enemyController = game.enemyController;
  }

  void render(Canvas c) {
    itemObjects.forEach((AnimatedObject object) => object.render(c));
  }

  void update(double t) {
    generateItems();
    bool isImmune = false;
    itemObjects.forEach((AnimatedObject object) {
      if (checkCrashed(game.player.playerRect, object.objectRect)) {
        if (object is Gem) {
          game.currentScore.score += 50;
        } else if (object is Sword && game.player.playerState != PlayerState.Sword) {
          isImmune = true;
        }
      }
    });
    itemObjects.removeWhere((AnimatedObject object) {
      if (object.isOffscreen) {
        return true;
      }
      if (checkCrashed(game.player.playerRect, object.objectRect)) {
        if (!(object is Sword)) {
          return true;
        } else if(PlayerState.Sword == game.player.playerState) {
          return false;
        } else {
          return true;
        }
      }
      return false;
    });
    if (isImmune) {
      game.player.playerState = PlayerState.Sword;
    }
    itemObjects.forEach((AnimatedObject object) => object.update(t));
  }

  void generateItems() {
    int numItemsToSpawn = game.rnd.nextInt(game.bins.length);
    double spacing = GlobalVars.spacingBetweenEnemySpawns;
    if (enemyController.enemyObjects.isEmpty) return;
    Rect lastEnemyObjectRect = enemyController.enemyObjects.last.objectRect;
    if (lastEnemyObjectRect.top <=
            game.screenSize.height +
                GlobalVars.offScreenTargetBottom -
                (lastEnemyObjectRect.height * spacing / 2) &&
        GlobalVars.canSpawnItem) {
      itemObjects = itemObjects..addAll(createItemsArray(numItemsToSpawn));
      GlobalVars.canSpawnItem = false;
    }
  }

  List<AnimatedObject> createItemsArray(int numItems) {
    List<AnimatedObject> items = List<AnimatedObject>();
    List<double> binsClone = List<double>()..addAll(game.bins);
    int spawnItemChance = game.rnd.nextInt(100);
    if (spawnItemChance <= 5) {
      int randomInt = game.rnd.nextInt(binsClone.length);
      items.add(Sword(game, binsClone[randomInt], game.screenSize.height));
      binsClone.removeAt(randomInt);
      numItems--;
    }
    for (int i = 0; i < numItems; i++) {
      int randomInt = game.rnd.nextInt(binsClone.length);
      items.add(Gem(game, binsClone[randomInt], game.screenSize.height));
      binsClone.removeAt(randomInt);
    }
    return items;
  }

  bool checkCrashed(Rect player, Rect object) {
    return (object.top <= player.bottom &&
        object.bottom - object.height / 2 > 0 &&
        object.left <= player.right &&
        object.right >= player.left);
  }
}
