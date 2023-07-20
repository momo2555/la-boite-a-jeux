//import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legendapp/controllers/user_connection.dart';
import 'package:legendapp/theme/main_theme.dart';
import 'package:legendapp/views/user_home_page.dart';
//import 'package:legendapp/vues/game/monitor/monitorHome.dart';
import 'package:legendapp/views/signin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /*SystemChrome.setPreferredOrientations([DeviceOrzerfdeientation.landscapeRight])  b 
      .then((_) {
    */
  runApp(const MyApp()); /*
  });*/
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
        title: 'Legend App',
        theme: mainTheme.defaultTheme,
     );
  }
}
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    UserConnection _userConnection = UserConnection();
    switch (settings.name) {
      case '/':
        //return MaterialPageRoute(builder: (context) => const MainSignPage());
        return MaterialPageRoute(
            builder: (context) => StreamBuilder(
                  stream: _userConnection.userStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        //if a user is connected show the client page
                        return Container();
                        
                      } else {
                        //if not showing sign in page
                        return SignInPage();
                      }
                    }

                    return Container();
                  },
                ));
      /*case '/signup_code':
        return MaterialPageRoute(
            builder: (context) => SignupCodePage(
                  user: settings.arguments as UserProfileModel,
                ));*/
     
      /* case '/newPost/confirmation':
        return MaterialPageRoute(
            builder: (context) => const NewPostConfirmationPage());
      case '/post':
        return MaterialPageRoute(
            builder: (context) =>
                PostPage(post: settings.arguments as PostModel));
      case '/channel':
        return MaterialPageRoute(
            builder: (context) =>
                ChannelPage(channel: settings.arguments as ChannelModel));
      case '/signup':
        return MaterialPageRoute(builder: (context) => const SignUpPage());
      case '/loading':
        if (settings.arguments != null) {
          Map<String, dynamic>? args =
              settings.arguments as Map<String, dynamic>;
          String? text = args.containsKey('text') ? args['text'] : null;
          Duration timeOffset = args.containsKey('timeOffset')
              ? args['timeOffset']
              : Duration.zero;
          Function()? callBack =
              args.containsKey('callBack') ? args['callBack'] : null;
          return MaterialPageRoute(
              builder: (context) => LoaderPage(
                    text: text,
                    timeOffset: timeOffset,
                    callBack: callBack,
                  ));
        } else {
          return MaterialPageRoute(
              builder: (context) => LoaderPage(
                    timeOffset: Duration(seconds: 1),
                  ));
        }
      */
      default:
        return MaterialPageRoute(builder: (context) => Container());
    }
  }
}
