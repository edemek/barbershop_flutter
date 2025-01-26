import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final String baseUrl = 'http://192.168.0.104:8000/api';

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      };

  Future<Map<String, String>> _getHeaders() async {
    final headers = Map<String, String>.from(_headers);
    final token = await _storage.read(key: 'token');
    if (token != null) {
      final bearerToken = token.startsWith('Bearer') ? token : 'Bearer $token';
      headers['Authorization'] = bearerToken;
      print('Bearer Token est: $bearerToken');
    } else {
      print('Bearer Token est null');
    }
    return headers;
  }
}
