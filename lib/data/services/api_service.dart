import 'dart:convert';
import 'package:barbershpo_flutter/data/repositories/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// Service de gestion des appels API
class ApiService {
  // Stockage sécurisé pour conserver le token utilisateur
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // URL de base de l'API (adapter en fonction de l'environnement)
  final String baseUrl = 'http://10.0.2.2:8000/api'; // Utiliser 10.0.2.2 pour les émulateurs Android

  // En-têtes par défaut pour les requêtes HTTP
  Map<String, String> get _headers => {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  // Récupérer les en-têtes avec le token d'autorisation, si disponible
  Future<Map<String, String>> _getAuthHeaders() async {
    final headers = Map<String, String>.from(_headers);
    final token = await _storage.read(key: 'token'); // Lire le token stocké
    if (token != null) {
      final bearerToken = token.startsWith('Bearer ') ? token : 'Bearer $token';
      headers['Authorization'] = bearerToken;
      print("Token: $bearerToken");
    } else {
      print("Token non disponible");
    }
    return headers;
  }

  // Récupérer le token CSRF depuis l'API
  Future<String?> _getCsrfToken() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/sanctum/csrf-cookie'),
        headers: _headers,
      );
      print('CSRF Response Status: ${response.statusCode}');
      print('CSRF Response Headers: ${response.headers}');

      final cookies = response.headers['set-cookie'];
      if (cookies != null) {
        // Extraire le token CSRF depuis les cookies
        final xsrfToken = cookies.split(';').firstWhere(
              (cookie) => cookie.trim().startsWith('XSRF-TOKEN='),
          orElse: () => '',
        );
        if (xsrfToken.isNotEmpty) {
          return Uri.decodeComponent(xsrfToken.split('=')[1]);
        }
      }
    } catch (e) {
      print('Erreur lors de la récupération du token CSRF: $e');
    }
    return null;
  }

  // Validation des entrées utilisateur
  bool validateInputs(String email, String password) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      print('Email invalide');
      return false;
    }
    if (password.length < 8) {
      print('Mot de passe trop court');
      return false;
    }
    return true;
  }

  // Inscription d'un nouvel utilisateur
  Future<User> register(String name, String email, String password,
      String passwordConfirmation) async {
    try {
      // Valider les entrées avant de procéder
      if (!validateInputs(email, password)) {
        throw 'Validation échouée: vérifiez vos entrées';
      }

      final headers = await _getAuthHeaders();
      final csrfToken = await _getCsrfToken();
      if (csrfToken != null) {
        headers['X-XSRF-TOKEN'] = csrfToken;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: headers,
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final user = User.fromJson(data['user']);
        user.token = data['token'];
        await _storage.write(key: 'token', value: user.token);
        return user;
      } else {
        throw _handleError(response);
      }
    } catch (e) {
      print('Erreur lors de l\'inscription: $e');
      rethrow;
    }
  }

  // Connexion d'un utilisateur
  Future<User> login(String email, String password) async {
    try {
      // Valider les entrées avant de procéder
      if (!validateInputs(email, password)) {
        throw 'Validation échouée: vérifiez vos entrées';
      }

      final headers = await _getAuthHeaders();
      final csrfToken = await _getCsrfToken();
      if (csrfToken != null) {
        headers['X-XSRF-TOKEN'] = csrfToken;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: headers,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = User.fromJson(data['user']);
        user.token = data['token'];
        await _storage.write(key: 'token', value: user.token);
        return user;
      } else {
        throw _handleError(response);
      }
    } catch (e) {
      print('Erreur lors de la connexion: $e');
      rethrow;
    }
  }

  // Gérer les erreurs des réponses HTTP
  String _handleError(dynamic error) {
    if (error is http.Response) {
      print('Error Response Status: ${error.statusCode}');
      print('Error Response Headers: ${error.headers}');
      print('Error Response Body: ${error.body}');
      try {
        final data = jsonDecode(error.body);
        return data['message'] ?? 'Une erreur est survenue';
      } catch (_) {
        return 'Erreur inattendue';
      }
    }
    return error.toString();
  }
}




/*
import 'dart:convert';

import 'package:barbershpo_flutter/data/repositories/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// Service de gestion des appels API
class ApiService {
  // Stockage sécurisé pour conserver le token utilisateur
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // URL de base de l'API
  final String baseUrl = 'http://192.168.0.104:8000/api';

  // En-têtes par défaut pour les requêtes HTTP
  Map<String, String> get _headers => {
        'Accept':
            'application/json', // Indique que la réponse doit être au format JSON
        'Content-Type':
            'application/json', // Spécifie que les données envoyées sont au format JSON
        'X-Requested-With':
            'XMLHttpRequest', // Indique que la requête provient d'un client AJAX
      };

  // Récupérer les en-têtes avec le token d'autorisation, si disponible
  Future<Map<String, String>> _getAuthHeaders() async {
    final headers = Map<String, String>.from(_headers);
    final token = await _storage.read(key: 'token'); // Lire le token stocké
    if (token != null) {
      // Ajouter le préfixe "Bearer" si absent
      final bearerToken = token.startsWith('Bearer ') ? token : 'Bearer $token';
      headers['Authorization'] = bearerToken;
      print("Token $bearerToken");
    } else {
      print("Token null");
    }
    return headers;
  }

  // Récupérer le token CSRF depuis l'API
  Future<String?> _getCsrfToken() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/sanctum/csrf-cookie'),
        headers: _headers,
      );
      print('CSRF Response Status: ${response.statusCode}');
      print('CSRF Response Headers: ${response.headers}');

      final cookies = response.headers['set-cookie'];
      if (cookies != null) {
        // Extraire le token CSRF depuis les cookies
        final xsrfToken = cookies.split(';').firstWhere(
              (cookie) => cookie.trim().startsWith('XSRF-TOKEN='),
              orElse: () => '',
            );
        if (xsrfToken.isNotEmpty) {
          return Uri.decodeComponent(xsrfToken.split('=')[1]);
        }
      }
    } catch (e) {
      print('Error fetching CSRF token: $e');
    }
    return null;
  }

  // Vérifier si un token valide est présent dans le stockage
  Future<bool> hasValidToken() async {
    final token = await _storage.read(key: 'token');
    return token != null;
  }

  // Inscription d'un nouvel utilisateur
  Future<User> register(String name, String email, String password,
      String passwordConfirmation) async {
    try {
      final headers = await _getAuthHeaders();
      final csrfToken = await _getCsrfToken();
      if (csrfToken != null) {
        headers['X-XSRF-TOKEN'] = csrfToken;
      }
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: headers,
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Convertir la réponse en objet utilisateur
        final data = jsonDecode(response.body);
        final user = User.fromJson(data['user']);
        user.token = data['token'];
        await _storage.write(
            key: 'token', value: user.token); // Stocker le token
        return user;
      } else {
        throw _handleError(response);
      }
    } catch (e) {
      print('Error registering user: $e');
      throw _handleError(e);
    }
  }

  // Connexion d'un utilisateur
  Future<User> login(String email, String password) async {
    try {
      final headers = await _getAuthHeaders();
      final csrfToken = await _getCsrfToken();
      if (csrfToken != null) {
        headers['X-XSRF-TOKEN'] = csrfToken;
      }
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: headers,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Traiter la réponse et créer un objet utilisateur
        final data = jsonDecode(response.body);
        final user = User.fromJson(data['user']);
        final token = data['token'].toString();
        user.token = token;
        await _storage.write(key: 'token', value: token); // Stocker le token
        return user;
      } else {
        throw _handleError(response);
      }
    } catch (e) {
      print('Error logging in user: $e');
      throw _handleError(e);
    }
  }

/*
  // Récupérer la liste des tâches
  Future<List<BarberShop>> getTodos() async {
    try {
      final headers = await _getAuthHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/todos'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        // Convertir la réponse en une liste de tâches
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> data = responseData['todos'] ?? [];
        return data.map((todo) => Todo.fromJson(todo)).toList();
      } else {
        print("Error getting todos: ${response.body}");
        throw _handleError(response);
      }
    } catch (e) {
      print('Error getting todos: $e');
      throw _handleError(e);
    }
  }

  // Créer une nouvelle tâche
  Future<Todo> createTodo(String title, String description) async {
    try {
      final headers = await _getAuthHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/todos'),
        headers: headers,
        body: jsonEncode({
          'title': title,
          'description': description,
        }),
      );

      if (response.statusCode == 201) {
        return Todo.fromJson(jsonDecode(response.body));
      } else {
        throw _handleError(response);
      }
    } catch (e) {
      print('Create todo error: $e');
      throw _handleError(e);
    }
  }

  // Mettre à jour une tâche existante
  Future<Todo> updateTodo(Todo todo) async {
    try {
      final headers = await _getAuthHeaders();
      final response = await http.put(
        Uri.parse('$baseUrl/todos/${todo.id}'),
        headers: headers,
        body: jsonEncode(todo.toJson()),
      );

      if (response.statusCode == 200) {
        return Todo.fromJson(jsonDecode(response.body));
      } else {
        throw _handleError(response);
      }
    } catch (e) {
      print('Update todo error: $e');
      throw _handleError(e);
    }
  }

  // Supprimer une tâche par son ID
  Future<void> deleteTodo(String id) async {
    try {
      final headers = await _getAuthHeaders();
      final response = await http.delete(
        Uri.parse('$baseUrl/todos/$id'),
        headers: headers,
      );

      if (response.statusCode != 204 && response.statusCode != 200) {
        throw _handleError(response);
      }
    } catch (e) {
      print('Delete todo error: $e');
      throw _handleError(e);
    }
  }

  // Supprimer le token stocké (déconnexion locale)
  Future<void> clearToken() async {
    await _storage.delete(key: 'token');
  }

  // Déconnexion de l'utilisateur (serveur et local)
  Future<void> logout() async {
    try {
      final headers = await _getAuthHeaders();
      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: headers,
      );
      if (response.statusCode != 401 && response.statusCode != 200) {
        throw _handleError(response);
      }
    } catch (e) {
      print('Logout error: $e');
      await clearToken(); // Supprimer le token local même en cas d'erreur
      throw _handleError(e);
    }
  }

 */
  // Gérer les erreurs des réponses HTTP
  String _handleError(dynamic error) {
    if (error is http.Response) {
      print('Error Response Status: ${error.statusCode}');
      print('Error Response Headers: ${error.headers}');
      print('Error Response Body: ${error.body}');
      try {
        final data = jsonDecode(error.body);
        return data['message'] ?? 'Something went wrong';
      } catch (_) {
        return 'Something went wrong';
      }
    }
    return error.toString();
  }
}

 */
