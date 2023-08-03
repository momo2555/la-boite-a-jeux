import 'package:flutter/material.dart';
import 'package:legendapp/components/simple_text.dart';
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
        if (request.url.startsWith('https://www.youtube.com/')) {
          return NavigationDecision.prevent;
        }
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
  }
  @override
  Widget build(BuildContext context) {
    print("non mais ho");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: SimpleText.darkTitle(widget.game.gameName),
      ),
      body: WebViewWidget(controller: _webViewController),
    );
  }
}