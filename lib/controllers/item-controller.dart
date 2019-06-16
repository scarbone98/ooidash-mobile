import 'dart:ui';
import 'package:ooidash/components/items/gem.dart';
import 'package:ooidash/box-game.dart';
import 'package:ooidash/components/animated-object.dart';
import 'package:ooidash/global-vars.dart';
import 'package:ooidash/controllers/enemy-controller.dart';

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
    itemObjects.forEach((AnimatedObject object) {
      object.update(t);
      if (checkCrashed(game.player.playerRect, object.objectRect)) {
        game.currentScore.score += 50;
      }
    });
    itemObjects.removeWhere((AnimatedObject object) =>
    object.isOffscreen ||
        checkCrashed(game.player.playerRect, object.objectRect));
  }

  void generateItems() {
    int numItemsToSpawn = game.rnd.nextInt(3);
    Rect lastEnemyObjectRect = enemyController.enemyObjects.last.objectRect;
    if (lastEnemyObjectRect.bottom <=
        game.screenSize.height - lastEnemyObjectRect.height * 1 && GlobalVars.canSpawnItem) {
      itemObjects = itemObjects
        ..addAll(createItemsArray(numItemsToSpawn));
      GlobalVars.canSpawnItem = false;
    }
//    AnimatedObject lastObject = enemyObjects.last;
//    List<AnimatedObject> itemsInLastRow = itemsObjects.where(
//            (AnimatedObject o) =>
//        o.objectRect.center.dy.toInt() ==
//            lastObject.objectRect.center.dy.toInt()).toList();
//    print(itemsInLastRow);
//    if (itemsInLastRow.isNotEmpty) {
//      return;
//    }
//    List<AnimatedObject> enemiesInLastRow = enemyObjects
//        .where((AnimatedObject o) =>
//            o.objectRect.center.dy == lastObject.objectRect.center.dy)
//        .toList();
//
//    List<double> binsCopy = List<double>()..addAll(bins);
//    for (AnimatedObject object in enemiesInLastRow) {
//      binsCopy.removeWhere(
//          (double val) => val.toInt() == object.objectRect.center.dx.toInt());
//    }
//    int numItemsToSpawn = (rnd.nextDouble() * (binsCopy.length - 1)).round();
//    while (binsCopy.length != numItemsToSpawn) {
//      int spawnIndex = (rnd.nextDouble() * (binsCopy.length - 1)).round();
//      itemsObjects.add(Gem(
//          this, binsCopy[spawnIndex], lastObject.objectRect.top + tileSize / 2));
//      binsCopy.removeAt(spawnIndex);
//    }
  }

  List<AnimatedObject> createItemsArray(int numItems) {
    List<AnimatedObject> items = List<AnimatedObject>();
    for (int i = 0; i < numItems; i++) {
      items.add(Gem(
          game,
          game.bins[(game.rnd.nextDouble() * (game.bins.length - 1)).round()],
          game.screenSize.height));
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