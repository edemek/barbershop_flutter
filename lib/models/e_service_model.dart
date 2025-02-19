// ignore_for_file: non_nullable_equals_parameter

/*
 * File name: e_service_model.dart
 * Last modified: 2025.02.05 at 12:33:38
 * Author: harrykouevi - https://github.com/harrykouevi
 * Copyright (c) 2025
 */

// import '../services/global_service.dart';
// import 'category_model.dart';
// import 'media_model.dart';
// import 'option_group_model.dart';
import '../features/Salon/models/salon_model.dart';
import 'parent/model_.dart';


class EService extends Model {
  String? name;
  String? description;
  // List<Media>? images;
  double? price;
  double? discountPrice;
  String? duration;
  bool? featured;
  bool? enableBooking;
  bool? enableAtSalon;
  bool? enableAtCustomerAddress;
  bool? isFavorite;
  // List<Category>? categories;
  // List<Category>? subCategories;
  // List<OptionGroup>? optionGroups;
  Salon? salon;

  EService({
    String? id,
    this.name,
    this.description,
    // this.images,
    this.price,
    this.discountPrice,
    this.duration,
    this.featured,
    this.enableBooking,
    this.enableAtSalon,
    this.enableAtCustomerAddress,
    this.isFavorite,
    // this.categories,
    // this.subCategories,
    // this.optionGroups,
    this.salon,
  }) {
    this.id = id;
  }

  EService.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    name = transStringFromJson(json, 'name');
    description = transStringFromJson(json, 'description');
    // images = mediaListFromJson(json, 'images');
    price = doubleFromJson(json, 'price');
    discountPrice = doubleFromJson(json, 'discount_price');
    duration = durationFromJson(json, 'duration');
    featured = boolFromJson(json, 'featured');
    enableBooking = boolFromJson(json, 'enable_booking');
    enableAtSalon = boolFromJson(json, 'enable_at_salon');
    enableAtCustomerAddress = boolFromJson(json, 'enable_at_customer_address');
    isFavorite = boolFromJson(json, 'is_favorite');
    // categories = listFromJson<Category>(
    //     json, 'categories', (value) => Category.fromJson(value));
    // subCategories = listFromJson<Category>(
    //     json, 'sub_categories', (value) => Category.fromJson(value));
    // optionGroups = listFromJson<OptionGroup>(json, 'option_groups',
    //     (value) => OptionGroup.fromJson(value, eServiceId: id));
    salon = objectFromJson(json, 'salon', (value) => Salon.fromJson(value!));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.hasData) data['id'] = this.id;
    if (name != null) data['name'] = this.name;
    if (this.description != null) data['description'] = this.description;
    if (this.price != null) data['price'] = this.price;
    if (discountPrice != null) data['discount_price'] = this.discountPrice;
    if (duration != null) data['duration'] = this.duration;
    if (featured != null) data['featured'] = this.featured;
    if (enableBooking != null) data['enable_booking'] = this.enableBooking;
    if (enableAtSalon != null) data['enable_at_salon'] = this.enableAtSalon;
    if (enableAtCustomerAddress != null)
      data['enable_at_customer_address'] = this.enableAtCustomerAddress;
    if (isFavorite != null) data['is_favorite'] = this.isFavorite;
    // if (this.categories != null) {
    //   data['categories'] = this.categories!.map((v) => v.id).toList();
    // }
    // if (this.images != null) {
    //   data['image'] = this.images!.map((v) => v.toJson()).toList();
    // }
    // if (this.subCategories != null) {
    //   data['sub_categories'] =
    //       this.subCategories!.map((v) => v.toJson()).toList();
    // }
    // if (this.optionGroups != null) {
    //   data['option_groups'] =
    //       this.optionGroups!.map((v) => v.toJson()).toList();
    // }
    // if (this.salon != null && this.salon!.hasData) {
    if (this.salon != null) {
      data['salon_id'] = this.salon!.id;
    }
    return data;
  }

  // String get firstImageUrl => this.images != null && this.images!.isNotEmpty
  //     ? this.images!.first.url
  //     : "${Get.find<GlobalService>().baseUrl}images/image_default.png";
  // String get firstImageIcon => this.images != null && this.images!.isNotEmpty
  //     ? this.images!.first.icon
  //     : "${Get.find<GlobalService>().baseUrl}images/image_default.png";
  // String get firstImageThumb => this.images != null && this.images!.isNotEmpty
  //     ? this.images!.first.thumb
  //     : "${Get.find<GlobalService>().baseUrl}images/image_default.png";

  @override
  bool get hasData {
    return super.hasData && name != null && description != null;
  }

  /*
  * Get the real price of the service
  * when the discount not set, then it return the price
  * otherwise it return the discount price instead
  * */
  double get getPrice {
    return (discountPrice ?? 0) > 0 ? discountPrice! : price!;
  }

  /*
  * Get discount price
  * */
  double get getOldPrice {
    return (discountPrice ?? 0) > 0 ? price! : 0;
  }

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      super == other &&
          other is EService &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          isFavorite == other.isFavorite &&
          enableBooking == other.enableBooking &&
          // categories == other.categories &&
          // subCategories == other.subCategories &&
          salon == other.salon;

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      salon.hashCode ^
      // categories.hashCode ^
      // subCategories.hashCode ^
      isFavorite.hashCode ^
      enableBooking.hashCode;
}
