
import 'package:barbershpo_flutter/models/parent/model.dart';


class BookingStatus extends Model {
  String? _status;

  String get status => _status ?? '';

  set status(String? value) {
    _status = value;
  }

  int? _order;

  int get order => _order ?? 0;

  set order(int? value) {
    _order = value;
  }

  BookingStatus({String? id, String? status, int? order}) {
    _order = order;
    _status = status;
    this.id = id;
  }
/*
  BookingStatus.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _status = transStringFromJson(json, 'status');
    _order = intFromJson(json, 'order');
  }*/

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['order'] = this.order;
    return data;
  }
}
