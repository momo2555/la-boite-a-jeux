import 'package:flutter/material.dart';
import 'package:legendapp/components/game_tile.dart';
import 'package:legendapp/components/simple_text.dart';
import 'package:legendapp/controllers/game_controller.dart';
import 'package:legendapp/models/game_model.dart';
import 'package:legendapp/utils/global_utils.dart';

class MainGamesPage extends StatefulWidget {
  const MainGamesPage({super.key});

  @override
  State<MainGamesPage> createState() => _MainGamesPageState();
}

class _MainGamesPageState extends State<MainGamesPage> {
  GameController _gameController = GameController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _gameController.getConnectedUserGame(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Widget> gameTiles = snapshot.data!.map((GameModel game) => GameTile(game: game)).toList();

          return GridView.count(
            padding: EdgeInsets.all(15),
            crossAxisCount: 5,
            childAspectRatio: 0.8,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: gameTiles,
              
              
            
            
          );
        } else {
          return Container();
        }
      },
    );
  }
}
