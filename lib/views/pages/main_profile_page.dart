import 'package:flutter/material.dart';
import 'package:legendapp/components/simple_text.dart';
import 'package:legendapp/controllers/profil_controller.dart';
import 'package:legendapp/controllers/user_connection.dart';
import 'package:legendapp/models/user_profile_model.dart';

class MainProfilePage extends StatefulWidget {
  const MainProfilePage({super.key});

  @override
  State<MainProfilePage> createState() => _MainProfilePageState();
  
}

class _MainProfilePageState extends State<MainProfilePage> {
  ProfileController _profileController = ProfileController();
  UserProfileModel? _profile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileController.getUserProfile.then((profile) {
      setState(() {
        _profile = profile;
      });
      
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Positioned(
                child: Container(
                  height: 140,
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                ),
              ),
              Positioned(
                top: 60,
                child: Container(
                  width: 145,
                  height: 145,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(75)
                  ),
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 65,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 80,
          ),
          SimpleText.name(_profile!=null?_profile!.userFullName:""),
        ],
      ),
    );
  }
}
