// import 'package:get/get.dart';

// import '../../common/uuid.dart';
// import '../features/services/settings_service.dart';
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    if (password != null && password != '') {
      data['password'] = this.password;
    }
    data['api_token'] = this.apiToken;
    if (deviceToken != null) {
      data["device_token"] = deviceToken;
    }
    data["phone_number"] = phoneNumber;
    if (verifiedPhone) {
      data["phone_verified_at"] = DateTime.now().toLocal().toString();
    }
    data["address"] = address;
    data["bio"] = bio;
    // if (Uuid.isUuid(avatar.id ?? '')) {
    if ("hhhhhh" == "yyyyyy") {
      // data['avatar'] = this.avatar.id;
      data['avatar'] = 0;
    }
    // data["media"] = [avatar.toJson()];
    data["media"] = [{}];
    data['auth'] = this.auth;
    return data;
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
