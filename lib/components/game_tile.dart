import 'package:flutter/material.dart';
import 'package:legendapp/components/simple_text.dart';
import 'package:legendapp/controllers/game_controller.dart';
import 'package:legendapp/models/game_model.dart';

class GameTile extends StatefulWidget {
  const GameTile({super.key, required this.game});
  final GameModel game;

  @override
  State<GameTile> createState() => _GameTileState();
}

class _GameTileState extends State<GameTile> {
  @override
  Widget build(BuildContext context) {
    return GridTile(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/game", arguments: widget.game);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Hero(
                          tag: widget.game.gameId,
                          child: Container(
                            decoration: BoxDecoration(
                              image: GameController.decorationImage(widget.game)
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: SimpleText.simple(widget.game.gameName),
                      )
                    ],
                  ),
                ),
              );
  }
}