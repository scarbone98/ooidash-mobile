import 'package:flutter/material.dart';
import 'singleton.dart';
import 'global-vars.dart';
import 'enums/game-enums.dart';

class UIManager extends StatefulWidget {
  final UIManagerState state = UIManagerState();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return state;
  }
}

class UIManagerState extends State<UIManager> {
  UIScreens currentScreen = UIScreens.home;
  String score = '0';

  Widget buildGameOver() {
    return Positioned.fill(
        child: Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            SimpleDialog(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[Text('Score'), Text(score)],
                  ),
                ),
                ButtonBar(
                  children: <Widget>[
                    RaisedButton(
                        onPressed: () =>
                            GlobalVars.gameState = GameState.Playing,
                        child: Text('Play again?'))
                  ],
                )
              ],
            ),
          ],
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ));
  }

  Widget buildHome() {
    return Positioned.fill(
        child: Column(
      children: <Widget>[
        SimpleDialog(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Ooidash'),
                RaisedButton(
                  child: Text('Start'),
                  onPressed: () => GlobalVars.gameState = GameState.Playing,
                )
              ],
            )
          ],
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ));
  }

  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget mainUI;
    switch(currentScreen) {
      case UIScreens.home:
        mainUI = buildHome();
        break;
      case UIScreens.playing:
        mainUI = SizedBox.shrink();
        break;
      case UIScreens.gameOver:
        mainUI = buildGameOver();
        break;
    }
    return Stack(children: <Widget>[
      mainUI
    ],);
  }
}

enum UIScreens { home, gameOver, playing }
