import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email est obligatoir.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Email Invalide.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mot de passe obligatoir.';
    }

    // Check for minimun password length
    if (value.length < 6) {
      return 'Le mot de passe doit avoir au moin 6 lettres';
    }

    // Check for uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Le mot de passe doit avoir au moin une Majuscule';
    }

    // Check for number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Le mot de passe doit avoir au moin un Chiffre';
    }

    // Check for spécialcharacter
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Le mot de passe doit avoir au moin un charactaire';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Numéro indiponible';
    }

    // -- Regular expression for phone, number,validation (assuming a 10-digit US phone number format
    final phoneRedExp = RegExp(r'^\d{10}$');

    if (!phoneRedExp.hasMatch(value)) {
      return 'Numéro ne remplit pas les condition';
    }

    return null;
  }
}

class TogoleseOtpFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Supprime les espaces et garde uniquement les chiffres
    String digitsOnly = newValue.text;

    // Limite à 1 chiffres maximum
    if (digitsOnly.length > 1) {
      digitsOnly = digitsOnly.substring(0, 1);
    }

    return TextEditingValue(
      text: digitsOnly,
      selection: TextSelection.collapsed(offset: digitsOnly.length),
    );
  }
}

class TogolesePhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Supprime les espaces et garde uniquement les chiffres
    String digitsOnly = newValue.text.replaceAll(' ', '').replaceAll('+228', '');

    // Limite à 8 chiffres maximum
    if (digitsOnly.length > 8) {
      digitsOnly = digitsOnly.substring(0, 8);
    }

    // Ajoute un espace toutes les 2 chiffres
    String formatted = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      formatted += digitsOnly[i];
      if ((i + 1) % 2 == 0 && i != digitsOnly.length - 1) {
        formatted += ' ';
      }
    }

    // Ajoute l'indicatif +228 au début
    formatted = '+228 $formatted';

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

// Méthode pour que la saisi soit en majusle
class UpperCaseTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Force tout le texte à être en majuscule
    String newText = newValue.text.toUpperCase();
    return newValue.copyWith(text: newText, selection: newValue.selection);
  }
}

class UserController extends GetxController {
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var phoneNumber = ''.obs;
  var shopName = ''.obs;

  // Méthode pour mettre à jour les données de l'utilisateur
  void updateUser(String fName, String lName, String email, String phone, String shop) {
    firstName.value = fName;
    lastName.value = lName;
    this.email.value = email;
    phoneNumber.value = phone;
    shopName.value = shop;
  }
}


