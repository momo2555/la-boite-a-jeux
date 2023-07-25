import 'dart:io';

class ResidenceModel {
  String? _residenceAddress = "";
  String? _residenceCity = "";
  String? _residenceGroup = "";
  String? _residenceName = "";
  String? _residenceZipCode = "";
  String? _residenceImage = "";
  String? _residenceId = "";
  File? _residenceImageFile;

  set residenceAddress (value) {
    _residenceAddress = value;
  }
   set residenceCity (value) {
    _residenceCity = value;
  }
   set residenceGroup (value) {
    _residenceGroup = value;
  }
   set residenceName (value) {
    _residenceName = value;
  }
  set residenceZipCode (value) {
    _residenceZipCode = value;
  }
  set residenceImage (value) {
    _residenceImage = value;
  }
  set residenceImageFile (value) {
    _residenceImageFile = value;
  }
  set residenceId (value) {
    _residenceId = value;
  }

  get residenceAddress  {
    return _residenceAddress;
  }
   get residenceCity  {
    return _residenceCity;
  }
   get residenceGroup  {
   return _residenceGroup;
  }
   get residenceName  {
    return _residenceName;
  }
   get residenceZipCode  {
    return _residenceZipCode;
  }
  get residenceImage  {
    return _residenceImage;
  }
  get residenceImageFile  {
    return _residenceImageFile;
  }
  get residenceId  {
   return  _residenceId;
  }


  Map<String, dynamic> toObject() {
    return {
      "residenceAddress" : _residenceAddress,
      "residenceCity" : _residenceCity,
      "residenceGroup" : _residenceGroup,
      "residenceName" : _residenceName,
      "residenceZipCode" : _residenceZipCode,
      "residenceImage" : _residenceImage,
    };
  }

}