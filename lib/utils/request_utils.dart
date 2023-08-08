import 'package:legendapp/controllers/game_controller.dart';
import 'package:legendapp/models/game_model.dart';

typedef GameRequest = Map<String, dynamic>;

Future<GameRequest> launchGameRequest (GameModel game) async {
 GameRequest launchGameData = {
      "header" : {
        "type" : "request",
        "from" : "controller"
      },
      "request" : {
        "exec" : "launchGame",
        "params" : {
          "gameId" : game.gameId,
          "gameUrl" : await GameController().downloadGameLink(game),
        }
      }
    };
    return launchGameData;
}

Future<GameRequest> closeGameRequest (GameModel game) async {
 GameRequest launchGameData = {
      "header" : {
        "type" : "request",
        "from" : "controller"
      },
      "request" : {
        "exec" : "closeGame",
        "params" : {
          "gameId" : game.gameId,
        }
      }
    };
    return launchGameData;
}