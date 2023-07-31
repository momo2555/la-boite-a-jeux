import 'package:flutter/material.dart';
import 'package:legendapp/models/game_model.dart';
import 'package:legendapp/models/monitor_model.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
class GameControlScreenPage extends StatefulWidget {
  const GameControlScreenPage({super.key, required this.game, required this.monitor});
  final GameModel game;
  final MonitorModel monitor;
  

  @override
  State<GameControlScreenPage> createState() => _GameControlScreenPageState();
}

class _GameControlScreenPageState extends State<GameControlScreenPage> {

  WebViewController _webViewController = WebViewController();
  _initWebViewController() {

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.game.gameName,
      ),
      //body: WebViewWidget
    );
  }
}