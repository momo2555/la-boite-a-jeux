import 'package:flutter/material.dart';
import 'package:legendapp/components/action_button.dart';
import 'package:legendapp/components/simple_text.dart';
import 'package:legendapp/utils/global_utils.dart';
import 'package:legendapp/views/pages/main_games_page.dart';

class PageInfo {
  final Widget page;
  final Widget rightIcon;
  final Widget title;
  final Widget menu;
  final Color topBgColor;
  final Widget floatingButton;
  PageInfo(
      {required this.page,
      required this.rightIcon,
      required this.title,
      required this.menu,
      required this.floatingButton,
      required this.topBgColor});
}

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  List<PageInfo> _pages = [];
  void _initPages() {
    if (_pages.length == 0) {
      _pages = [
        PageInfo(
          title: SimpleText.bigIrish("Profil", 4),
          topBgColor: Theme.of(context).primaryColor,
          rightIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.power_settings_new,
              size: 40,
            ),
            color: Theme.of(context).colorScheme.background,
          ),
          page: MainGamesPage(),
          menu: Container(),
          floatingButton: ActionButton.floating("Mes messages", () {}, Icons.message),
        ),
        PageInfo(
          title: SimpleText.bigIrish("Jouer", 1),
          topBgColor: Theme.of(context).colorScheme.background,
          rightIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              size: 40,
            ),
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          page: MainGamesPage(),
          menu: Container(),
          floatingButton: ActionButton.floating("Plus de jeux", () {}, Icons.add),
        ),
        PageInfo(
          title: SimpleText.bigIrish("Blog", 1),
          topBgColor: Theme.of(context).colorScheme.background,
          rightIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              size: 40,
            ),
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          page: MainGamesPage(),
          menu: Container(),
          floatingButton: ActionButton.floating("Publier", () {}, Icons.add),
        )
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    _initPages();
    return ValueListenableBuilder(
      valueListenable: Globals.homeIndex,
      builder: (context, value, widget) {
        PageInfo page = _pages[value];
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: page.title,
              automaticallyImplyLeading: false,
              backgroundColor: page.topBgColor,
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: page.rightIcon,
                )
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              elevation: 0,
              //fixedColor: Theme.of(context).backgroundColor,
              selectedItemColor: Theme.of(context).colorScheme.onSecondary,
              unselectedItemColor: Theme.of(context).colorScheme.background,
              currentIndex: Globals.homeIndex.value,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 11,
              unselectedFontSize: 11,

              items: [
                BottomNavigationBarItem(
                  icon: Globals.homeIndex.value == 0
                      ? Icon(Icons.person)
                      : Icon(Icons.person),
                  label: "Profil",
                  backgroundColor: Theme.of(context).primaryColorLight,
                ),
                BottomNavigationBarItem(
                  icon: Globals.homeIndex.value == 1
                      ? Icon(Icons.sports_esports)
                      : Icon(Icons.sports_esports),
                  label: "Jouer",
                  backgroundColor: Theme.of(context).primaryColorLight,
                ),
                BottomNavigationBarItem(
                  icon: Globals.homeIndex.value == 2
                      ? Icon(Icons.forum)
                      : Icon(Icons.forum), //GeIcons.personBlack,
                  label: "Blog",
                  backgroundColor: Theme.of(context).primaryColorLight,
                ),
              ],
              onTap: (int index) {
                Globals.homeIndex.value = index;
              },
            ),
            floatingActionButton: Container(
              height: 60,
              child: page.floatingButton,
            ),
            body: page.page,
          ),
        );
      },
    );
  }
}
