import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:legendapp/controllers/cache_storage_controller.dart';
import 'package:legendapp/controllers/profile_controller.dart';
import 'package:legendapp/controllers/user_connection.dart';
import 'package:legendapp/models/residence_model.dart';
import 'package:legendapp/models/user_model.dart';
import 'package:legendapp/models/user_profile_model.dart';
import 'package:legendapp/utils/image_utils.dart';

class ResidenceController {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  UserConnection _userConnection = UserConnection();
  ProfileController _profileController = ProfileController();
  CacheStorageController _cloudDownloader = CacheStorageController();

  void addResidence(ResidenceModel newResidence) async {
    UserModel user = await _userConnection.UserConnected;
    //newPost.setPostUserId = user.getUid;
    //create a new document for the new post (auto generated uid)
    DocumentReference ref = _fireStore.collection('residences').doc();
    //uid of the post
    String uid = ref.id;
    //upload photos in the firestorage

    //TODO : upload the image
    /*int i = 0;
    List<String?> storageImageNames = [];
    for (String img in newRestaurant.getPostTempImagePaths) {
      File imgFile = File(img);
      String newPath = uid + '_'+i.toString();
      storageImageNames.add(newPath);
      Reference uploadRef = fireStorage.ref('postImages/' + uid + '/' + newPath); //in a unique folder
      uploadRef.putFile(imgFile);
      i++;
    }
    //add images storages names
    newPost.setPostStorageImageNames = storageImageNames;*/
    
    //add the new post in the doc
    ref.set(newResidence.toObject());
  }


  Future<ResidenceModel> getUserResidence(UserProfileModel user) async {
    var doc = await _fireStore.collection('residences').doc(user.userResidence);
    ResidenceModel residence = await getResidenceById(doc.id, true);
    return residence;
  }


  Future<ResidenceModel> getConnectedUserResidence() async {
    UserProfileModel user = await _profileController.getUserProfile;
    return await getUserResidence(user);
  }

  Future<ResidenceModel> getResidenceById(String residenceId, bool withPicture) async {
    ResidenceModel residence = ResidenceModel();
    DocumentReference residenceRef =
        _fireStore.collection('residences').doc(residenceId);
    //get user data
    DocumentSnapshot residenceSnapshot = (await residenceRef.get());
    residence = docToResidenceModel(residenceSnapshot);
    if(withPicture) {
      residence = await getImage(residence);
    }
      
    return residence;

  }
   Future<ResidenceModel> getResidence(DocumentReference residenceRef) async {
    ResidenceModel residence = ResidenceModel();
    //get user data
    DocumentSnapshot residenceSnapshot = (await residenceRef.get());
    residence = docToResidenceModel(residenceSnapshot);
    
    
    return residence;

  }

  ResidenceModel docToResidenceModel(DocumentSnapshot doc) {
    ResidenceModel residence = ResidenceModel();
    residence.residenceName = doc.get('residenceName');
    //post.setPostCurrentUserLike = postSnapshot.get('postCurrentUserLike');
    residence.residenceAddress = doc.get('residenceAddress');
    residence.residenceCity = doc.get('residenceCity');
    residence.residenceGroup = doc.get('residenceGroup');
    residence.residenceImage = doc.get('residenceImage');
    residence.residenceZipCode = doc.get('residenceZipCode');
    residence.residenceId = doc.id;
    

    return residence;
  }

  Future<ResidenceModel> getImage(ResidenceModel residence) async {
    
       
      //download images
      //get temp
      String? residenceImageStorageName = residence.residenceImage;
     
      File fileImg = await _cloudDownloader.downloadFromCloud('residences/', (residenceImageStorageName as String), LocalSaveMode.userDocuments);
      residence.residenceImageFile = fileImg;
    
      
    return residence;
    
   
  }
  Future<ResidenceModel> getResidenceUpdate(ResidenceModel residence, bool withPicture) async {
    residence = await getResidenceById(residence.residenceId, withPicture);
    return residence;
  }
  /*Stream<List<Future<MeaelModel>>> converDocs(QueryDocumentSnapshot<Map<String, dynamic>> snapshots) async* {
    List<ResidenceModel> posts = [];
    
  }*/  // on part sur une autre stratégie
  /*Stream<List<RestaurantModel>> getAllresidences()  {
    return _fireStore.collection('residences').limit(20).snapshots().map((event) => event.docs.map((e) =>  docToResidenceModel(e)).toList() );
    
  }*/
  /*Stream<List<ResidenceModel>> getResidencesOfRestaurant(RestaurantModel restaurant) async* {
    yield* _fireStore.collection("residences").where("residenceRestaurantId", isEqualTo: restaurant.restaurantId).snapshots(includeMetadataChanges: true).map((event) => event.docs.map((e) => docToResidenceModel(e)).toList());
  }*/

  void updateResidenceImageNames(ResidenceModel residence) {
    
    
    if(residence.residenceImage!=null) {
      residence.residenceImage = getFileName(residence.residenceId, residence.residenceImageFile as File);
    }
    
  }
  Future<void> editResidence(ResidenceModel residence) async {
    //upload image
    updateResidenceImageNames(residence);
    await _cloudDownloader.uploadImage(residence.residenceImage, "residences/${residence.residenceImage}");
    //Save data
     _fireStore.collection("residences").doc(residence.residenceId).set(residence.toObject());

  }
  Future<void> createResidence(ResidenceModel residence) async {
    var ref = _fireStore.collection("residences").doc();
    residence.residenceId = ref.id;
    editResidence(residence);

  }
  static DecorationImage? decorationImage(ResidenceModel? residence) {
    if(residence!=null) print(residence.residenceImage);
    if (residence?.residenceImageFile != null) {
      return DecorationImage(
        image: FileImage(residence?.residenceImageFile),
        fit: BoxFit.cover,
        alignment: Alignment.center,
      );
    } else {
      return null;
    }
  }
}

 