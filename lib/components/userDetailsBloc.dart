import 'package:flutter/material.dart';
import 'package:legendapp/components/simple_text.dart';
import 'package:legendapp/models/residence_model.dart';
import 'package:legendapp/models/user_profile_model.dart';
import 'package:legendapp/utils/color_utils.dart';

class UserDetailsBloc extends StatefulWidget {
  const UserDetailsBloc({super.key, this.profile, this.residence});
  final UserProfileModel? profile;
  final ResidenceModel? residence;

  @override
  State<UserDetailsBloc> createState() => _UserDetailsBlocState();
}

class _UserDetailsBlocState extends State<UserDetailsBloc> {
  Widget element(IconData icon, String value) {
     return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Icon(
                        icon,
                        color: ColorUtils.secondary,
                        size: 35,
                      ),
                    ),
                    Flexible(
                      child: SimpleText.simple(value),
                      
                    ),
                  ],
                );
  }

  @override
  Widget build(BuildContext context) {
    UserProfileModel? profile = widget.profile;
    ResidenceModel? residence = widget.residence;
     return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: ColorUtils.textLight),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               element(Icons.location_city, residence != null
                          ? "${residence.residenceName} - ${residence.residenceCity}"
                          : ""),
                SizedBox(
                  height: 15,
                ),
                element(Icons.assignment_ind, profile != null
                          ? profile.userPositionName
                          : ""),
                SizedBox(
                  height: 15,
                ),
                element(Icons.email, profile != null
                          ? profile.email
                          : ""),
              ],
            ),
          ),
        );
  }
}