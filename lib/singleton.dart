import 'box-game.dart';
import 'ui-manager.dart';

class Singleton {
  Singleton._privateConstructor();

  static final BoxGame _gameInstance = BoxGame();
  static final UIManager _uiManager = UIManager();

  static BoxGame get gameInstance {
    return _gameInstance;
  }

  static UIManager get uiManager {
    return _uiManager;
  }
}
