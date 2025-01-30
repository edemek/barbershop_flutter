// AuthController: Contrôle les opérations d'authentification dans l'application Flutter.import 'package:get/get.dart';

import 'package:barbershpo_flutter/data/repositories/user.dart';
import 'package:barbershpo_flutter/data/services/api_service.dart';
import 'package:barbershpo_flutter/features/personalization/screens/profile/profile.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // Instance du service API pour communiquer avec le backend.
  final ApiService _apiService = ApiService();

  // Stocke l'utilisateur actuel sous forme de variable réactive.
  final Rx<User?> currentUser = Rx<User?>(null);

  // Indique si une opération est en cours (chargement).
  final RxBool isLoading = false.obs;

  // Contient les messages d'erreur pour les afficher à l'utilisateur.
  final RxString error = "".obs;

  // Indique si l'utilisateur est connecté ou non.
  bool get isLoggedIn => currentUser.value != null;

  // Méthode pour enregistrer un nouvel utilisateur.
  Future<void> register(String name, String email, String password,
      String passwordConfirmation) async {
    try {
      isLoading.value = true; // Début du chargement.
      error.value = ""; // Réinitialisation des erreurs.

      // Appel de l'API pour enregistrer l'utilisateur.
      final newUser = await _apiService.register(
          name, email, password, passwordConfirmation);

      // Mise à jour de l'utilisateur actuel.
      currentUser.value = newUser;

      // Récupération des tâches de l'utilisateur.
      //await Get.find<TodoController>().fetchTodos();

      // Navigation vers la page des tâches.
      //Get.offAllNamed('/todos');
      Get.offAll(ProfileScreen());
    } catch (e) {
      // Capture et affichage des erreurs.
      error.value = e.toString();
    } finally {
      // Fin du chargement.
      isLoading.value = false;
    }
  }

  // Méthode pour connecter un utilisateur.
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true; // Début du chargement.
      error.value = ""; // Réinitialisation des erreurs.

      // Appel de l'API pour authentifier l'utilisateur.
      final user = await _apiService.login(email, password);

      // Mise à jour de l'utilisateur actuel.
      currentUser.value = user;

      // Récupération des tâches de l'utilisateur.
      //await Get.find<TodoController>().fetchTodos();

      // Navigation vers la page des tâches.
      //Get.offAllNamed('/todos');
      Get.offAll(ProfileScreen());
    } catch (e) {
      // Capture et affichage des erreurs.
      error.value = e.toString();
    } finally {
      // Fin du chargement.
      isLoading.value = false;
    }
  }

/*
  // Méthode pour déconnecter un utilisateur.
  Future<void> logout() async {
    try {
      isLoading.value = true; // Début du chargement.
      error.value = ""; // Réinitialisation des erreurs.

      // Appel de l'API pour déconnecter l'utilisateur.
      await _apiService.logout();

      // Réinitialisation de l'utilisateur actuel.
      currentUser.value = null;

      // Suppression du token localement.
      await _apiService.clearToken();

      // Vidage de la liste des tâches.
      Get.find<TodoController>().todos.clear();

      // Navigation vers la page de connexion.
      Get.offAllNamed('/login');
    } catch (e) {
      // Capture et affichage des erreurs.
      error.value = e.toString();
    } finally {
      // Fin du chargement.
      isLoading.value = false;
    }
  }
*/
}
