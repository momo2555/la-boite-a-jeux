import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:legendapp/models/user_model.dart';
import 'package:legendapp/controllers/user_connection.dart';
import 'package:legendapp/views/user_home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String _password = '';
  String _email = '';

  Widget _passwordEntry() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) => setState(() {
        _password = value;
      }),
    );
  }

  Widget _emailEntry() {
    return TextFormField(
      onChanged: (value) => setState(() {
        _email = value;
      }),
    );
  }

  Widget _submitButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () async {
          UserConnection userConnection = UserConnection();
          UserModel newUser;
          userConnection.Authentification(_email, _password).then((value) {
            newUser = value;
            //if the user is connected
            /*if (newUser.isConnected()) {
              //page des utilisateurs connecté
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Client();
                },
              ));
            } else {
              //message d'erreur
            }*/
          });
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )),
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero)),
        child: Container(
          height: 50,
          width: 50,
          child: const Icon(
            Icons.arrow_forward_rounded,
            color: null,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        elevation: 0,
      ),*/
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                children: [
                  Text(
                    'Connexion',
                    style: TextStyle(
                      fontSize: 50,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  
                  const SizedBox(
                    height: 40,
                  ),
                  _emailEntry(),
                  const SizedBox(
                    height: 20,
                  ),
                  _passwordEntry(),
                  const SizedBox(
                    height: 30.0,
                  ),
                  _submitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
