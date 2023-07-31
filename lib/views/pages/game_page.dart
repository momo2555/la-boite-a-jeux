import 'package:flutter/material.dart';
import 'package:legendapp/components/action_button.dart';
import 'package:legendapp/components/monitor_list_dialog.dart';
import 'package:legendapp/components/simple_text.dart';
import 'package:legendapp/controllers/game_controller.dart';
import 'package:legendapp/controllers/monitor_controller.dart';
import 'package:legendapp/models/game_model.dart';
import 'package:legendapp/utils/color_utils.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.game});
  final GameModel game;
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: ColorUtils.background,
        elevation: 0,
        automaticallyImplyLeading: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.transparent],
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  child: Container(
                    width: double.infinity,
                    height: 270,
                    decoration: BoxDecoration(
                      image: GameController.decorationCoverImage(widget.game),
                    ),
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 220,
                  child: Container(
                    width: 104,
                    height: 104,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ColorUtils.background,
                    ),
                  ),
                ),
                Positioned(
                  top: 224,
                  left: 34,
                  child: Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      image: GameController.decorationImage(widget.game),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Positioned(
                  top: 210,
                  right: 30,
                  child:
                      ActionButton.squared("Lancer", () {
                        showDialog(context: context, builder: (BuildContext context){
                        return MonitorListDialog(game: widget.game);
                      });

                      }, Icons.play_arrow),
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SimpleText.darkTitle("${widget.game.gameName}"),
            ),
            Container(
              width: double.infinity,
              height: 220,
              color: ColorUtils.secondary,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SimpleText.simple(widget.game.gameDescription),
            ),
          ],
        ),
      ),
    );
  }
}
