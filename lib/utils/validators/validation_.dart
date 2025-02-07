import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email est obligatoire.';
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
      return 'Mot de passe obligatoire.';
    }

    // Check for minimun password length
    if (value.length < 6) {
      return 'Le mot de passe doit avoir au moins 6 lettres';
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

class NoSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Si le texte est vide, retourner tel quel
    if (newValue.text.isEmpty) {
      return newValue;
    }

    String newText = newValue.text.replaceAll(' ', '');

    // Si c'est juste le préfixe +228, le garder
    if (newText == '+228') {
      return newValue;
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: newText.length,
      ),
    );
  }
}

class TogolesePhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Ne rien faire si le texte est vide
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Garde uniquement les chiffres et le +
    String cleaned = newValue.text.replaceAll(RegExp(r'[^\d+]'), '');

    // Si c'est le début de la saisie, ajouter +228
    if (!cleaned.startsWith('+228')) {
      cleaned = '+228' + cleaned.replaceAll('+', '');
    }

    // Enlève +228 temporairement pour le formatage
    String digitsOnly = cleaned.replaceAll('+228', '');

    // Limite à 8 chiffres maximum
    if (digitsOnly.length > 8) {
      digitsOnly = digitsOnly.substring(0, 8);
    }

    // Formate avec des espaces
    String formatted = '';
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && i % 2 == 0) {
        formatted += ' ';
      }
      formatted += digitsOnly[i];
    }

    // Réajoute le préfixe
    if (formatted.isNotEmpty) {
      formatted = '+228 ' + formatted;
    } else {
      formatted = '+228';
    }

    // Calcule la nouvelle position du curseur
    int newCursor = newValue.selection.baseOffset;
    newCursor = formatted.length;

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newCursor),
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
  var UToken = ''.obs;
  var UserRole = ''.obs;

  // Méthode pour mettre à jour les données de l'utilisateur avec possibilité d'être à nul
  void updateUser(String? fName, String? lName, String? email, String? phone, String? shop, String? Utoken, String? Role) {
    if(fName != null)firstName.value = fName;
    if (lName != null) lastName.value = lName;
    if (email != null) this.email.value = email;
    if (phone != null) phoneNumber.value = phone;
    if (shop != null) shopName.value = shop;
    if (Utoken != null) UToken.value = Utoken;
    if (Role != null) UserRole.value = Role;
  }
}


