import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:legendapp/components/action_button.dart';
import 'package:legendapp/components/simple_input.dart';
import 'package:legendapp/components/simple_text.dart';
import 'package:legendapp/controllers/user_connection.dart';
import 'package:legendapp/utils/global_utils.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String _password = '';
  String _email = '';
  bool connectionWait = false;
  UserConnection _userConnection = UserConnection();

  final GlobalKey<FormState> _signinKey = GlobalKey<FormState>();

  Widget _passwordEntry() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SimpleText.label("password"),
        SimpleInput(
          style: "filled",
          type: "password",
          onChange: (value) {
            _password = value;
          },
        )
      ],
    );
  }

  Widget _emailEntry() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SimpleText.label("E-mail"),
        SimpleInput(
          style: "filled",
          onChange: (value) {
            _email = value;
          },
        )
      ],
    );
  }

  Widget _submitButton() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ActionButton.simpleBlue("Se connecter", () {
            setState(() {
              connectionWait = true;
            });
            final form = _signinKey.currentState!;

            if (form.validate()) {
              form.save();
              _userConnection.Authentification(_email, _password).then((value) {
                if (value.uid == "" && value.email == "") {
                  Fluttertoast.showToast(
                    msg:
                        "Les identifiants que vous avez renseignés sont incorrectes",
                    gravity: ToastGravity.TOP,
                    backgroundColor: Theme.of(context).colorScheme.error,
                    textColor: Theme.of(context).colorScheme.background,
                  );
                } else {
                  Globals.homeIndex.value = 1;
                }
                setState(() {
                  connectionWait = false;
                });
              });
            }
          }, connectionWait)
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        elevation: 0,
      ),*/
      floatingActionButton: Container(
        height: 60,
        child: ActionButton.floating(
          "Besoin d'aide",
          () {},
          Icons.help,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(110, 80, 110, 80),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      children: [
                        SimpleText.veryBigIrish("La boîte à jeux"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Form(
              key: _signinKey,
              child: Padding(
                key: const ValueKey(1),
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    _emailEntry(),
                    const SizedBox(
                      height: 20,
                    ),
                    _passwordEntry(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    _submitButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
