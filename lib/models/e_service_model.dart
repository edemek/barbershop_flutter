import 'package:barbershpo_flutter/models/parent/model.dart';
import '../features/Salon/models/salon_model.dart';
import 'category_model.dart';

class EService extends Model {
  String? _name;
  String? _description;
  double? _price;
  double? _discountPrice;
  String? _duration;
  bool? _featured;
  bool? _enableBooking;
  bool? _enableAtSalon;
  bool? _enableAtCustomerAddress;
  bool? _isFavorite;
  List<Category>? _categories;
  List<Category>? _subCategories;
  Salon? _salon;

  // Getters
  String? get name => _name;
  String? get description => _description;
  double? get price => _price;
  double? get discountPrice => _discountPrice;
  String? get duration => _duration;
  bool? get featured => _featured;
  bool? get enableBooking => _enableBooking;
  bool? get enableAtSalon => _enableAtSalon;
  bool? get enableAtCustomerAddress => _enableAtCustomerAddress;
  bool? get isFavorite => _isFavorite;
  List<Category>? get categories => _categories;
  List<Category>? get subCategories => _subCategories;
  Salon? get salon => _salon;

  // Setters
  set name(String? name) => _name = name;
  set description(String? description) => _description = description;
  set price(double? price) => _price = price;
  set discountPrice(double? discountPrice) => _discountPrice = discountPrice;
  set duration(String? duration) => _duration = duration;
  set featured(bool? featured) => _featured = featured;
  set enableBooking(bool? enableBooking) => _enableBooking = enableBooking;
  set enableAtSalon(bool? enableAtSalon) => _enableAtSalon = enableAtSalon;
  set enableAtCustomerAddress(bool? enableAtCustomerAddress) =>
      _enableAtCustomerAddress = enableAtCustomerAddress;
  set isFavorite(bool? isFavorite) => _isFavorite = isFavorite;
  set categories(List<Category>? categories) => _categories = categories;
  set subCategories(List<Category>? subCategories) => _subCategories = subCategories;
  set salon(Salon? salon) => _salon = salon;

  EService({
    String? id,
    String? name,
    String? description,
    double? price,
    double? discountPrice,
    String? duration,
    bool? featured,
    bool? enableBooking,
    bool? enableAtSalon,
    bool? enableAtCustomerAddress,
    bool? isFavorite,
    List<Category>? categories,
    List<Category>? subCategories,
    Salon? salon,
  }) {
    this.id = id;
    _name = name;
    _description = description;
    _price = price;
    _discountPrice = discountPrice;
    _duration = duration;
    _featured = featured;
    _enableBooking = enableBooking;
    _enableAtSalon = enableAtSalon;
    _enableAtCustomerAddress = enableAtCustomerAddress;
    _isFavorite = isFavorite;
    _categories = categories;
    _subCategories = subCategories;
    _salon = salon;
  }

  EService.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    _name = json['name'] as String?;
    _description = json['description'] as String?;
    _price = double.tryParse(json['price']?.toString() ?? '');
    _discountPrice = double.tryParse(json['discount_price']?.toString() ?? '');
    _duration = json['duration'] as String?;
    _featured = json['featured'] as bool?;
    _enableBooking = json['enable_booking'] as bool?;
    _enableAtSalon = json['enable_at_salon'] as bool?;
    _enableAtCustomerAddress = json['enable_at_customer_address'] as bool?;
    _isFavorite = json['is_favorite'] as bool?;

    if (json['categories'] != null) {
      _categories = <Category>[];
      json['categories'].forEach((v) {
        _categories!.add(Category.fromJson(v));
      });
    }

    if (json['sub_categories'] != null) {
      _subCategories = <Category>[];
      json['sub_categories'].forEach((v) {
        _subCategories!.add(Category.fromJson(v));
      });
    }

    _salon = json['salon'] != null ? Salon.fromJson(json['salon']) : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,  // Explicitly include id in the json
      'name': _name,
      'description': _description,
    };
    data['name'] = _name;
    data['description'] = _description;
    data['price'] = _price;
    data['discount_price'] = _discountPrice;
    data['duration'] = _duration;
    data['featured'] = _featured;
    data['enable_booking'] = _enableBooking;
    data['enable_at_salon'] = _enableAtSalon;
    data['enable_at_customer_address'] = _enableAtCustomerAddress;
    data['is_favorite'] = _isFavorite;

    if (_categories != null) {
      data['categories'] = _categories!.map((v) => v.toJson()).toList();
    }

    if (_subCategories != null) {
      data['sub_categories'] = _subCategories!.map((v) => v.toJson()).toList();
    }

    if (_salon != null) {
      data['salon'] = _salon!.toJson();
    }

    return data;
  }
}