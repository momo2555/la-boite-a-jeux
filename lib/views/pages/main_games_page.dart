import 'package:flutter/material.dart';
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
        print(snapshot.data);
        if (snapshot.hasData) {
          List<Widget> gameTiles = snapshot.data!.map((GameModel e) => GridTile(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/game", arguments: e);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: GameController.decorationImage(e)
                          ),
                        ),
                      ),
                      Container(
                        child: SimpleText.simple(e.gameName),
                      )
                    ],
                  ),
                ),
              )).toList();

          return GridView.count(
            padding: EdgeInsets.all(15),
            crossAxisCount: 4 ,
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
