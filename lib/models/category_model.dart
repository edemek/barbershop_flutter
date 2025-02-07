import 'package:barbershpo_flutter/models/parent/model.dart';
import 'package:flutter/material.dart';
import 'e_service_model.dart';

class Category extends Model {
  String? _name;
  String? _description;
  Color? _color;
 // Media? _image;
  bool? _featured;
  List<Category>? _subCategories;
  List<EService>? _eServices;

  // Getters
  String? get name => _name;
  String? get description => _description;
  Color? get color => _color;
 // Media? get image => _image;
  bool? get featured => _featured;
  List<Category>? get subCategories => _subCategories;
  List<EService>? get eServices => _eServices;

  // Setters
  set name(String? name) => _name = name;
  set description(String? description) => _description = description;
  set color(Color? color) => _color = color;
 // set image(Media? image) => _image = image;
  set featured(bool? featured) => _featured = featured;
  set subCategories(List<Category>? subCategories) => _subCategories = subCategories;
  set eServices(List<EService>? eServices) => _eServices = eServices;

  Category({
    String? id,
    String? name,
    String? description,
    Color? color,
  //  Media? image,
    bool? featured,
    List<Category>? subCategories,
    List<EService>? eServices,
  }) {
    this.id = id;
    _name = name;
    _description = description;
    _color = color;
  //  _image = image;
    _featured = featured;
    _subCategories = subCategories;
    _eServices = eServices;
  }

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;  // Explicitly set id from json
    _name = json['name'] as String?;
    _description = json['description'] as String?;

    // Convert color from hex string to Color object
    if (json['color'] != null) {
      String colorString = json['color'].toString();
      if (colorString.startsWith('#')) {
        colorString = colorString.replaceFirst('#', '');
      }
      _color = Color(int.parse('0xFF$colorString'));
    }

    //_image = json['image'] != null ? Media.fromJson(json['image']) : null;
    _featured = json['featured'] as bool?;

    if (json['sub_categories'] != null) {
      _subCategories = <Category>[];
      (json['sub_categories'] as List).forEach((v) {
        _subCategories!.add(Category.fromJson(v));
      });
    }

    if (json['e_services'] != null) {
      _eServices = <EService>[];
      (json['e_services'] as List).forEach((v) {
        _eServices!.add(EService.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,  // Explicitly include id in the json
      'name': _name,
      'description': _description,
    };

    // Convert Color to hex string
    if (_color != null) {
      data['color'] = '#${_color!.value.toRadixString(16).substring(2)}';
    }
/*
    if (_image != null) {
      data['image'] = _image!.toJson();
    }*/

    data['featured'] = _featured;

    if (_subCategories != null) {
      data['sub_categories'] = _subCategories!.map((v) => v.toJson()).toList();
    }

    if (_eServices != null) {
      data['e_services'] = _eServices!.map((v) => v.toJson()).toList();
    }

    return data;
  }

  // Helper method to get color from hex string
  static Color? colorFromHex(String? hexString) {
    if (hexString == null) return null;

    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));

    return Color(int.parse(buffer.toString(), radix: 16));
  }

  // Helper method to convert color to hex string
  String? colorToHex() {
    if (_color == null) return null;
    return '#${_color!.value.toRadixString(16).substring(2)}';
  }
}