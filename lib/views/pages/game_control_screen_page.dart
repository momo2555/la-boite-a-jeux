import 'package:flutter/material.dart';
import 'package:legendapp/components/simple_text.dart';
import 'package:legendapp/controllers/monitor_controller.dart';
import 'package:legendapp/models/game_model.dart';
import 'package:legendapp/models/monitor_model.dart';
import 'package:webview_flutter/webview_flutter.dart';
class GameControlScreenPage extends StatefulWidget {
  const GameControlScreenPage({super.key, required this.game, required this.monitor});
  final GameModel game;
  final MonitorModel monitor;
  

  @override
  State<GameControlScreenPage> createState() => _GameControlScreenPageState();
}

class _GameControlScreenPageState extends State<GameControlScreenPage> {
  MonitorController _monitorController = MonitorController();
  WebViewController _webViewController = WebViewController();
  void _initWebViewController() {
    _webViewController = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse('http://${widget.monitor.getIp}:2227/game/controller.html'));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initWebViewController();
    _monitorController.launchGame(widget.game, widget.monitor);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: SimpleText.darkTitle(widget.game.gameName),
      ),
      body: WebViewWidget(controller: _webViewController),
    );
  }
}