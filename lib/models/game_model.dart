import 'dart:io';

class GameModel {
  late String _gameId;
  late String _gameName;
  late String _gameImage;
  late String _gameCoverImage;
  late String _gameArchive;
  late String _gameDescription;
  
  File? _gameImageFile;
  File? _gameCoverImageFile;
  File? _gameArchiveFile;
  //late String monitorPage;
  //late String controllerPage;
  GameModel() {}
  set gameId(value) {
    _gameId = value;
  }
  set gameName(value) {
    _gameName = value;
  }
  set gameImage(value) {
    _gameImage = value;
  }
  set gameCoverImage(value) {
    _gameCoverImage = value;
  }
  set gameDescription(value) {
    _gameDescription = value;
  }
  set gameImageFile(value) {
    _gameImageFile = value;
  }
  set gameCoverImageFile(value) {
    _gameCoverImageFile = value;
  }
  set gameArchive(value) {
    _gameArchive = value;
  }
  set gameArchiveFile(value) {
    _gameArchiveFile = value;
  }


  get gameId  {
    return _gameId;
  }
  get gameName  {
    return _gameName;
  }
  get gameImage  {
    return _gameImage;
  }
  get gameCoverImage  {
    return _gameCoverImage;
  }
  get gameDescription  {
    return _gameDescription;
  }
  get gameImageFile  {
    return _gameImageFile;
  }
  get gameCoverImageFile  {
    return _gameCoverImageFile;
  }
  get gameArchive {
    return _gameArchive;
  }
  get gameArchiveFile {
    return _gameArchiveFile;
  }

  Map<String, dynamic> toObject () {
    return {
      "gameId" : _gameId,
      "gameName" : _gameName,
      "gameImage" : _gameImage,
      "gameCoverImage": _gameCoverImage,
      "gameDescription" : _gameDescription,
      "gameArchive" : _gameArchive,
      
    };
  }
  
}