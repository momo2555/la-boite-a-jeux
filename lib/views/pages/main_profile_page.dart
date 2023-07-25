import 'package:flutter/material.dart';
import 'package:legendapp/components/simple_text.dart';
import 'package:legendapp/controllers/profile_controller.dart';
import 'package:legendapp/controllers/residence_controller.dart';
import 'package:legendapp/controllers/user_connection.dart';
import 'package:legendapp/models/residence_model.dart';
import 'package:legendapp/models/user_profile_model.dart';
import 'package:legendapp/utils/color_utils.dart';

class MainProfilePage extends StatefulWidget {
  const MainProfilePage({super.key});

  @override
  State<MainProfilePage> createState() => _MainProfilePageState();
  
}

class _MainProfilePageState extends State<MainProfilePage> {
  ProfileController _profileController = ProfileController();
  ResidenceController _residenceController = ResidenceController();
  UserProfileModel? _profile;
  ResidenceModel? _residence;
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
      _residenceController.getConnectedUserResidence().then((residence) {
        setState(() {
          _residence = residence;
        });
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
                      BoxDecoration(color: ColorUtils.primary),
                ),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: ColorUtils.background,
                    image: ResidenceController.decorationImage(_residence),
                  ),
                
              ),),
              Positioned(
                top: 60,
                child: Container(
                  width: 145,
                  height: 145,
                  decoration: BoxDecoration(
                    color: ColorUtils.background,
                    borderRadius: BorderRadius.circular(75)
                  ),
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: ColorUtils.secondary,
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
