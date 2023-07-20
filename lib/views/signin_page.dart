import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:legendapp/components/simple_input.dart';
import 'package:legendapp/components/simple_text.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SimpleText.label("password"),
        SimpleInput(
          style: "filled",
          type: "password",
        )
      ],
    );
  }

  Widget _emailEntry() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SimpleText.label("Login"),
        SimpleInput(
          style: "filled",
        )
      ],
    );
  }

  Widget _submitButton() {
    return Container();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Center(
                child: SingleChildScrollView(
                  
                  
                  child: Container(
                    padding: EdgeInsets.fromLTRB(100, 80, 100, 80),
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
            Padding(
              padding: const EdgeInsets.all(50.0),
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
                    height: 30.0,
                  ),
                  _submitButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
