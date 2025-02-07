// AuthController: Contrôle les opérations d'authentification dans l'application Flutter.import 'package:get/get.dart';
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:barbershpo_flutter/data/services/api_service.dart';
import 'package:barbershpo_flutter/features/personalization/screens/profile/profile.dart';
import '../features/services/auth_service.dart';

import '../../../../common/ui.dart';
import '../../../models/user_model.dart';
import '../../features/repositories/user_repository.dart';
import '../../../routes/app_routes.dart';
import '../../../features/services/auth_service.dart';
import '../features/root/controllers/root_controller.dart';

import 'package:get/get.dart';

class AuthController extends GetxController {
  late UserRepository _userRepository;
  AuthController() {
    _userRepository = UserRepository();
  }

  // Stocke l'utilisateur actuel sous forme de variable réactive.
  final Rx<User> currentUser = Get.find<AuthService>().user;
  // final Rx<User?> currentUser = Rx<User?>(null);
  // late GlobalKey<FormState> loginFormKey;
  final loginFormKey = GlobalKey<FormState>();

  static AuthController get to => Get.find(); // Access the

  // Indique si une opération est en cours (chargement).
  final RxBool loading = false.obs;
  // final loading = false.obs;

  // Contient les messages d'erreur pour les afficher à l'utilisateur.
  final RxString error = "".obs;

  // Indique si l'utilisateur est connecté ou non.
  // bool get isLoggedIn => currentUser.value != null;

  // Méthode pour enregistrer un nouvel utilisateur.
  Future<void> register(String name, String email, String password,
      String passwordConfirmation) async {
    loading.value = true; // Début du chargement.
    try {
      // await _userRepository.sendCodeToPhone();
      loading.value = false;
      await Get.toNamed(Routes.PHONE_VERIFICATION);

      Get.offAll(ProfileScreen());
    } catch (e) {
      // Capture et affichage des erreurs.
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }

  // Méthode pour connecter un utilisateur.
  Future<void> login(String phonenumber, String password) async {
    print('nous etions dans le controleur');
    //------------------------------
    print(loginFormKey.currentState);
    print(loginFormKey.currentState!.validate());
    Get.focusScope?.unfocus();
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();
      loading.value = true;
      try {
        print(currentUser.value);
        // await Get.find<FireBaseMessagingService>().setDeviceToken();
        currentUser.value = await _userRepository.login(currentUser.value);
        //await _userRepository.signInWithEmailAndPassword(currentUser.value.email!, currentUser.value.apiToken!);
        await Get.find<RootController>().changePage(0);
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        loading.value = false;
      }
    }

    // //''''''''''''''''''''''''''''''''

    // try {
    //   isLoading.value = true; // Début du chargement.
    //   error.value = ""; // Réinitialisation des erreurs.

    //   // Appel de l'API pour authentifier l'utilisateur.
    //   final user = await _apiService.login(email, password);

    //   // Mise à jour de l'utilisateur actuel.
    //   currentUser.value = user;

    //   // Récupération des tâches de l'utilisateur.
    //   //await Get.find<TodoController>().fetchTodos();

    //   // Navigation vers la page des tâches.
    //   //Get.offAllNamed('/todos');
    //   Get.offAll(ProfileScreen());
    // } catch (e) {
    //   // Capture et affichage des erreurs.
    //   error.value = e.toString();
    // } finally {
    //   // Fin du chargement.
    //   isLoading.value = false;
    // }
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
