import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legendapp/controllers/cache_storage_controller.dart';
import 'package:legendapp/controllers/profile_controller.dart';
import 'package:legendapp/controllers/user_connection.dart';
import 'package:legendapp/models/game_model.dart';
import 'package:legendapp/models/user_model.dart';
import 'package:legendapp/models/user_profile_model.dart';
import 'package:legendapp/utils/image_utils.dart';

class GameController {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  UserConnection _userConnection = UserConnection();
  ProfileController _profileController = ProfileController();
  CacheStorageController _cloudDownloader = CacheStorageController();

  void addGame(GameModel newGame) async {
    UserModel user = await _userConnection.UserConnected;
    //newPost.setPostUserId = user.getUid;
    //create a new document for the new post (auto generated uid)
    DocumentReference ref = _fireStore.collection('games').doc();
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
    ref.set(newGame.toObject());
  }


  Stream<List<GameModel>> getUserGames(UserProfileModel user) async* {
    String userId = user.uid;
    var ref = await _fireStore.collection('purchases').where("purchaseUserId", isEqualTo: userId).get();
    print(ref.docs);
    print(userId);
    List<GameModel> games =[];
    for(var doc in ref.docs) {
      games.add(await getGameById(doc.get("purchaseGameId"), true));
      yield games;
    }
    
  }


  Stream<List<GameModel>> getConnectedUserGame() async* {
    UserProfileModel user = await _profileController.getUserProfile;
    yield* getUserGames(user);
  }

  Future<GameModel> getGameById(String gameId, bool withPicture) async {
    GameModel game = GameModel();
    DocumentReference gameRef =
        _fireStore.collection('games').doc(gameId);
    //get user data
    DocumentSnapshot gameSnapshot = (await gameRef.get());
    game = docToGameModel(gameSnapshot);
    if(withPicture) {
      game = await getImage(game);
    }
      
    return game;

  }
   Future<GameModel> getGame(DocumentReference gameRef) async {
    GameModel game = GameModel();
    //get user data
    DocumentSnapshot gameSnapshot = (await gameRef.get());
    game = docToGameModel(gameSnapshot);
    
    
    return game;

  }

  GameModel docToGameModel(DocumentSnapshot doc) {
    GameModel game = GameModel();
    game.gameName = doc.get('gameName');
    //post.setPostCurrentUserLike = postSnapshot.get('postCurrentUserLike');
    game.gameImage = doc.get('gameImage');
    game.gameCoverImage = doc.get('gameCoverImage');
    game.gameDescription = doc.get('gameDescription');
    game.gameImage = doc.get('gameImage');
    game.gameArchive = doc.get('gameArchive');
    game.gameId = doc.id;
    

    return game;
  }

  Future<GameModel> getImage(GameModel game) async {
    
       
      //download images
      //get temp
      String? gameImageStorageName = game.gameImage;
      String? gameCoverImageStorageName = game.gameCoverImage;
     
      File fileImg = await _cloudDownloader.downloadFromCloud('games/${game.gameId}/', (gameImageStorageName as String), LocalSaveMode.userDocuments);
      File fileCoverImg = await _cloudDownloader.downloadFromCloud('games/${game.gameId}/', (gameCoverImageStorageName as String), LocalSaveMode.userDocuments);
      game.gameImageFile = fileImg;
      game.gameCoverImageFile = fileCoverImg;
    
      
    return game;
    
   
  }
  Future<GameModel> getGameUpdate(GameModel game, bool withPicture) async {
    game = await getGameById(game.gameId, withPicture);
    return game;
  }
  /*Stream<List<Future<MeaelModel>>> converDocs(QueryDocumentSnapshot<Map<String, dynamic>> snapshots) async* {
    List<GameModel> posts = [];
    
  }*/  // on part sur une autre stratégie
  /*Stream<List<RestaurantModel>> getAllgames()  {
    return _fireStore.collection('games').limit(20).snapshots().map((event) => event.docs.map((e) =>  docToGameModel(e)).toList() );
    
  }*/
  /*Stream<List<GameModel>> getGamesOfRestaurant(RestaurantModel restaurant) async* {
    yield* _fireStore.collection("games").where("gameRestaurantId", isEqualTo: restaurant.restaurantId).snapshots(includeMetadataChanges: true).map((event) => event.docs.map((e) => docToGameModel(e)).toList());
  }*/

  void updateGameImageNames(GameModel game) {
    
    
    if(game.gameImage!=null) {
      game.gameImage = getFileName(game.gameId, game.gameImageFile as File);
    }
    
  }
  Future<void> editGame(GameModel game) async {
    //upload image
    updateGameImageNames(game);
    await _cloudDownloader.uploadImage(game.gameImage, "games/${game.gameId}/${game.gameImage}");
    //Save data
     _fireStore.collection("games").doc(game.gameId).set(game.toObject());

  }

  Future<void> createGame(GameModel game) async {
    var ref = _fireStore.collection("games").doc();
    game.gameId = ref.id;
    editGame(game);

  }

  static DecorationImage? decorationImage(GameModel? game) {
    if(game!=null) print(game.gameImage);
    if (game?.gameImageFile != null) {
      return DecorationImage(
        image: FileImage(game?.gameImageFile),
        fit: BoxFit.fill,
        alignment: Alignment.center,
      );
    } else {
      return null;
    }
  }

  Future<String> downloadGameLink(GameModel game) async {
    String gamePath = "games/${game.gameId}/${game.gameArchive}";
    String downloadUrl = await _cloudDownloader.getFileDowloadUrl(gamePath);
    return downloadUrl;

  }

  static DecorationImage? decorationCoverImage(GameModel? game) {
    if(game!=null) print(game.gameCoverImage);
    if (game?.gameCoverImageFile != null) {
      return DecorationImage(
        image: FileImage(game?.gameCoverImageFile),
        fit: BoxFit.fill,
        alignment: Alignment.center,
      );
    } else {
      return null;
    }
  }


}