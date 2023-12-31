import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:legendapp/models/game_model.dart';
import 'package:legendapp/models/monitor_model.dart';
import 'package:legendapp/utils/request_utils.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:udp/udp.dart';

class MonitorController {
  //monitor detection class
  List<MonitorModel> monitorsList = [];
  StreamController<List<MonitorModel>> monitorListStreamController =
      StreamController<List<MonitorModel>>();
  void runDeviceClient() async {
    var result = '';

    UDP? receiver, sender;

    Future.wait([
      UDP.bind(Endpoint.any(port: Port(2222))).then((udp) {
        sender = udp;
        print('send udp ');
        return udp.send(
          'legend_get_monitor'.codeUnits,
          Endpoint.broadcast(port: Port(2222)),
        );
      }),
      UDP.bind(Endpoint.any(port: Port(2223))).then((udp) {
        receiver = udp;
        return udp.asStream(timeout: Duration(seconds: 5)).listen((dgram) {
          //getting the result (result = the result of the udp request)
          result = String.fromCharCodes(dgram!.data);
          Map<String, dynamic> monitorMap = jsonDecode(result);

          if (monitorMap.containsKey("server")) {
            if (monitorMap['server']) {
              //add in the list a new monitor
              addMonitor(
                  MonitorModel(name: monitorMap["name"], ip: monitorMap["ip"]));
              //adding a new state in the stream
              monitorListStreamController.sink.add(monitorsList);
              //print(result);
            }
          } else {
            //there is an a error in the transmission => do notthing
          }
        });
      }),
    ]);

    // receiving\listening

    // close the UDP instances and their sockets.
    //sender.close();
    //receiver?.close();
    //print("connection closed");
  }

  Stream<List<MonitorModel>> get monitorListStream {
    return monitorListStreamController.stream;
  }

  void addMonitor(MonitorModel monitor) {
    //TO DO check if the monitor all ready exist
    monitorsList.add(monitor);
  }

  WebSocket? _monitorConnection;
  bool _monitorConnected = false;

  Future<void> launchGame(GameModel game, MonitorModel monitor) async {
    if (!_monitorConnected) {
      var url = "ws://${monitor.getIp}:2225";
      _monitorConnection = await WebSocket.connect(url);
      GameRequest launchGameData = await launchGameRequest(game);
      _monitorConnection!.add(jsonEncode(launchGameData));
      _monitorConnected = true;
    }
  }

  Future<void> closeGame(GameModel game, MonitorModel monitor) async {
    if (_monitorConnected && _monitorConnection != null) {
      GameRequest launchGameData = await closeGameRequest(game);
      _monitorConnection!.add(jsonEncode(launchGameData));
      _monitorConnection!.close();
      _monitorConnected = true;
    }
  }

  registerMonitorResponse(Function(dynamic) callback) async {
    if (_monitorConnection!= null && _monitorConnected) {
      _monitorConnection!.listen((event) {
        callback(event);
      });
    }
  }
}
