import 'package:get/get.dart';

/*

//import '../services/settings_service.dart';
//import 'media_model.dart';
import 'parent/model.dart';

class User extends Model {
  String? name;
  String? email;
  String? password;
 // Media avatar = Media();
  String? apiToken;
  String? deviceToken;
  String? phoneNumber;
  bool verifiedPhone = false;
  String? verificationId;
  String? address;
  String? bio;
  bool auth = false;

  User({
    String? id,
    this.name,
    this.email,
    this.password,
    this.apiToken,
    this.deviceToken,
    this.phoneNumber,
    this.verificationId,
    this.verifiedPhone = false,
    this.address,
    this.bio,
   // Media? avatar,
    //this.auth   = false,
  }) {
    //this.avatar = avatar ?? Media();
    this.id = id;
  }

  User.fromJson(Map<String, dynamic>? json) {
    name = stringFromJson(json, 'name');
    email = stringFromJson(json, 'email');
    apiToken = stringFromJson(json, 'api_token');
    deviceToken = stringFromJson(json, 'device_token');
    phoneNumber = stringFromJson(json, 'phone_number');
    verifiedPhone = boolFromJson(json, 'phone_verified_at');
    //avatar = mediaFromJson(json, 'avatar');
    auth = boolFromJson(json, 'auth');
    try {
      address = json?['custom_fields']['address']['view'];
    } catch (e) {
      address = stringFromJson(json, 'address');
    }
    try {
      bio = json?['custom_fields']['bio']['view'];
    } catch (e) {
      bio = stringFromJson(json, 'bio');
    }
    super.fromJson(json);
  }
}
*/