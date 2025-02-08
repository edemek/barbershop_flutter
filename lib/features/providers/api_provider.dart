/*
 * File name: api_provider.dart
 * Last modified: 2025.02.05 at 15:25:33
 * Author: harrykouevi - https://github.com/harrykouevi
 * Copyright (c) 2025
 */

import 'dart:convert';
// import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../common/custom_trace.dart';
import '../services/auth_service.dart';
import '../services/global_service.dart';

mixin ApiClient {
  final globalService = Get.find<GlobalService>();
  final AuthService authService = Get.find<AuthService>();
  String baseUrl = '';
  late Map<String, String> _headers; // Store headers
  final _httpClient = http.Client();

  Map<String, String> get optionsNetwork => _headers;
  ApiClient get httpClient => this;

  Future <ApiClient> init() async {
    // Initialize any necessary components here if needed
    _headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${authService.apiToken}",
    };
    return this;
  }

  String getBaseUrl(String path) {
    if (!path.endsWith('/')) {
      path += '/';
    }
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    if (!baseUrl.endsWith('/')) {
      return baseUrl + '/' + path;
    }
    return baseUrl + path;
  }

  String getApiBaseUrl(String path) {
    String _apiPath = globalService.global.value.apiPath ?? '';
    if (path.startsWith('/')) {
      return getBaseUrl(_apiPath) + path.substring(1);
    }
    return getBaseUrl(_apiPath) + path;
  }

  Uri getApiBaseUri(String path) {
    return Uri.parse(getApiBaseUrl(path));
  }

  Uri getBaseUri(String path) {
    return Uri.parse(getBaseUrl(path));
  }

  void printUri(StackTrace stackTrace, Uri uri) {
    Get.log(CustomTrace(stackTrace, message: uri.toString()).toString());
  }

  // Method to manage loading states (if needed)
  bool isLoading({String? task, List<String>? tasks}) {
    // Implement loading state management logic if necessary
    return false; // Placeholder; replace with actual implementation
  }

  // Method to set locale in headers
  void setLocale(String locale) {
    _headers['Accept-Language'] = locale;
  }

  // Method to force refresh (custom logic)
  void forceRefresh() {
    // Implement your logic here for refreshing data or resetting states
    print("Force refresh called");
    // Example: Clear cached data or reset some variables
  }

  // Method to unforce refresh (custom logic)
  void unForceRefresh() {
    // Implement any logic needed to revert the force refresh state
    print("Unforce refresh called");
  }

  Future<http.Response> getUri(Uri path, {Map<String, String>? headers}) async {
    final combinedHeaders = {
      ..._headers,
      if (headers != null) ...headers
    }; // Combine default and provided headers
    return await _httpClient.get(path, headers: combinedHeaders);
  }

  Future<http.Response> post(Uri path,
      {Map<String, String>? headers, Object? body}) async {
    final uri = path;
    final combinedHeaders = {
      ..._headers,
      if (headers != null) ...headers
    }; // Combine default and provided headers
    return await http.post(uri,
        headers: combinedHeaders, body: jsonEncode(body));
  }

  Future<http.Response> put(Uri path,
      {Map<String, String>? headers, Object? body}) async {
    final uri = path;
    final combinedHeaders = {
      ..._headers,
      if (headers != null) ...headers
    }; // Combine default and provided headers
    return await http.put(uri,
        headers: combinedHeaders, body: jsonEncode(body));
  }

  // Define the delete method
  Future<http.Response> deleteUri(Uri path,
      {Map<String, String>? headers}) async {
    final combinedHeaders = {
      ..._headers,
      if (headers != null) ...headers,
    }; // Combine default and provided headers

    return await http.delete(
      path,
      headers: combinedHeaders,
    );
  }


}
