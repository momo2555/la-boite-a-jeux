import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legendapp/components/simple_text.dart';
import 'package:legendapp/controllers/monitor_controller.dart';
import 'package:legendapp/models/game_model.dart';
import 'package:legendapp/models/monitor_model.dart';
import 'package:legendapp/utils/color_utils.dart';

class MonitorListDialog extends StatefulWidget {
  final GameModel game;
  const MonitorListDialog({Key? key, required this.game}) : super(key: key);

  @override
  _MonitorListDialogState createState() => _MonitorListDialogState();
}

class _MonitorListDialogState extends State<MonitorListDialog> {
  late List<ListTile> _monitorsTile = [];
  late Stream<List<MonitorModel>>? _monitorModelsList;

  @override
  void initState() {
    //create the stream;
    MonitorController _monitorController = MonitorController();
    _monitorController.runDeviceClient();
    _monitorModelsList = _monitorController.monitorListStream;

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context));
  }

  Widget contentBox(context) {
    print('you suck');
    return Container(
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          //borderRadius: BorderRadius.circular(20),
          shape: BoxShape.rectangle),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: ColorUtils.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
                child: SimpleText.yellowTitle("Séléctionner la boîte à jeux")),
          ),
          StreamBuilder(
            stream: _monitorModelsList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  List<MonitorModel> monitorsList =
                      snapshot.data as List<MonitorModel>;

                  for (MonitorModel monitor in monitorsList) {
                    print(monitor.name);
                    _monitorsTile.add(ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.cast_rounded,
                          color: ColorUtils.secondary,
                          size: 45,
                        ),
                      ),
                      title: SimpleText.simple(monitor.getName),
                      subtitle: SimpleText.simple(monitor.getIp),
                      onTap: () {
                        // TODO begin game controller actions
                        Navigator.pushNamed(context, "./game_control_screen", arguments:  [widget.game, monitor]);
                        /*Navigator.push(context, MaterialPageRoute(builder: (context){
                                  //return ControllerHome(monitor: monitor, game: widget.game);
                                }));*/
                      },
                    ));
                  }

                  return Expanded(
                    child: ListView(
                      children: _monitorsTile,
                    ),
                  );
                }
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }
}
