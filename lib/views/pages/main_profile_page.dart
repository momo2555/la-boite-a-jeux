import 'package:flutter/material.dart';
import 'package:legendapp/components/simple_text.dart';
import 'package:legendapp/controllers/profile_controller.dart';
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
  bool _changeState = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileController.getUserProfile.then((profile) async {
      setState(() {
        _profile = profile;
      });
      if(_profile!=null) {
        await _profileController.getUserProfileImage(_profile!);
        setState(() {
          
        });
      }
      
      
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
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      radius: 65,
                      foregroundImage: _profile?.userProfileImageFile!=null? FileImage(_profile!.userProfileImageFile):null,
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
  @override
  void dispose() {
    // TODO: implement dispose
    _changeState = false;
    super.dispose();
  }
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if(_changeState){
      super.setState(fn);
    }
    
  }
}
