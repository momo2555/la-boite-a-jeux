import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:legendapp/controllers/cache_storage_controller.dart';
import 'package:legendapp/controllers/user_connection.dart';
import 'package:legendapp/models/user_model.dart';
import 'package:legendapp/models/user_profile_model.dart';
import 'package:legendapp/utils/image_utils.dart';

class ProfileController {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  UserConnection _userConnection = UserConnection();
  CacheStorageController _cloudDowloader = CacheStorageController();

  Future<UserProfileModel> get getUserProfile async {
    UserModel user = await _userConnection.UserConnected;
    UserProfileModel userProfile = UserProfileModel.byModel(user);
    //get the user reference
    DocumentReference profileDataRef =
        _fireStore.collection('users').doc(userProfile.uid);
    //get user data
    DocumentSnapshot profileData = (await profileDataRef.get());
    userProfile.userFirstName = profileData.get('userFirstName');
    //userProfile.userDescription= profileData.get('userDescription');
    userProfile.userLastName = profileData.get('userLastName');
    //userProfile.phone = profileData.get('userPhone');
    userProfile.userProfileImage = profileData.get('userProfileImage');
    userProfile.email = profileData.get('userMail');
    userProfile.userResidence = profileData.get('userResidence');
    userProfile.userDate = profileData.get('userDate');
    userProfile.userPosition = profileData.get('userPosition');
    //get the link of the profile image
    /*Reference imgRef = fireStorage.ref('userImages/'+(userProfile.userProfileImage??''));
    userProfile.userProfileImageURL = await imgRef.getDownloadURL();*/

    return userProfile;
  }

  Future<UserProfileModel> getUserProfileById(String userId) async {
    //get the user Id
    UserModel user = UserModel('', '', '', userId);

    UserProfileModel userProfile = UserProfileModel.byModel(user);
    //get the user reference
    DocumentReference profileDataRef =
        _fireStore.collection('users').doc(userProfile.uid);
    //get user data
    DocumentSnapshot profileData = (await profileDataRef.get());
    userProfile.userFirstName = profileData.get('userFirstName');
    //userProfile.userDescription = profileData.get('userDescription');
    userProfile.userLastName = profileData.get('userLastName');
    // userProfile.phone = profileData.get('userPhone');
    userProfile.userProfileImage = profileData.get('userProfileImage');
    userProfile.email = profileData.get('userMail');
    userProfile.userResidence = profileData.get('userResidence');
    userProfile.userDate = profileData.get('userDate');
    userProfile.userPosition = profileData.get('userPosition');
    //get the link of the profile image

    //Reference imgRef = fireStorage.ref('userImages/'+(userProfile.userProfileImage??''));
    //userProfile.userProfileImageURL = await imgRef.getDownloadURL(); // TODO error dowload time exceeded

    return userProfile;
  }

  Future<UserProfileModel> createProfileBUserModel(UserModel user) async {
    UserProfileModel userProfile = UserProfileModel.byModel(user);
    //create the new doc
    DocumentReference profileDataRef =
        _fireStore.collection('users').doc(user.uid);
    profileDataRef.set(userProfile.toObject());
    //create reference to the mail address
    DocumentReference mailPhoneRef =
        _fireStore.collection('phonemail').doc(user.phone);
    Map<String, String> mailData = {"email": user.email};
    mailPhoneRef.set(mailData);
    return userProfile;
  }

  Future<UserProfileModel> createProfileByProfileModel(
      UserProfileModel userProfile) async {
    //create the new doc
    DocumentReference profileDataRef = _fireStore
        .collection('users')
        .doc(userProfile.uid); //must not be null '' (uid)
    profileDataRef.set(userProfile.toObject());
    //create reference to the mail address
    //DocumentReference mailPhoneRef = _fireStore.collection('phonemail').doc(userProfile.phone);
    //Map<String, String> mailData = {"email": userProfile.email};
    //mailPhoneRef.set(mailData);
    return userProfile;
  }

  Future<void> getUserProfileImage(UserProfileModel _userProfile) async {
    _userProfile.userProfileImageFile = await _cloudDowloader.downloadFromCloud(
        "users/", _userProfile.userProfileImage);
  }

  Future<void> saveUserProfile(UserProfileModel userProfile) async {
    //upload image
    if (userProfile.userProfileImageFile != null) {
      userProfile.userProfileImage =
          getFileName(userProfile.uid, userProfile.userProfileImageFile);
      await _cloudDowloader.uploadImage(userProfile.userProfileImageFile,
          "users/${userProfile.userProfileImage}"); //in a unique folder
    }
    //enregistrement dans la data base
    DocumentReference profileDataRef =
        _fireStore.collection('users').doc(userProfile.uid);
    profileDataRef.set(userProfile.toObject());
  }
}
