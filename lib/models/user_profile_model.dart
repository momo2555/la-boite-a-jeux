import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:legendapp/models/user_model.dart';

class UserProfileModel extends UserModel {
  String? _userFirstName;
  String? _userLastName;
  String? _userProfileImage;
  File? _userProfileImageFile;
  String? _userResidence;
  String? _userPosition;
  Timestamp? _userDate;
  UserProfileModel(email, password, uid) : super(email, password, uid);
  UserProfileModel.byModel(UserModel user)
      : super(user.email, '','', user.uid);


  set userFirstName(value) {
    _userFirstName = value;
  }

  set userLastName(value) {
    _userLastName = value;
  }

  set userProfileImage(value) {
    _userProfileImage = value;
  }

  set userResidence(value) {
    _userResidence = value;
  }

  set userPosition(value) {
    _userPosition = value;
  }

  set userDate(value) {
    _userDate = value;
  }

  set userProfileImageFile (value) {
    _userProfileImageFile = value;
  }



  get userFirstName {
    return _userFirstName;
  }

  get userLastName {
    return _userLastName;
  }

  get userProfileImage {
    return _userProfileImage;
  }


  get userResidence {
   return _userResidence;
  }

  get userPosition {
    return _userPosition;
  }

  get userDate {
    return _userDate;
  }

  get userProfileImageFile {
    return _userProfileImageFile;
  }

  get userFullName {
    return "$userFirstName $userLastName";
  }

  Map<String, dynamic> toObject() {
    return {
      "userFirstName" : _userFirstName,
      "userLastName" : _userLastName,
      "userProfileImage" : _userProfileImage,
      "userMail" : email,
      "userResidence" : _userResidence,
      "userPosition" : _userPosition,
      "userDate" : userDate,

    };
  }
}
