import 'package:flutter/material.dart';
import '../account/views/account_view.dart';
import '../account/views/account_view_customer.dart';
import 'home/homeScreen.dart';
import 'home/mainScreen.dart';

class VerificationPage extends StatefulWidget {
  final String emailOrPhone;
  //final bool isChecked;
  final String role;
  const VerificationPage({required this.emailOrPhone, required this.role, super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController codeController = TextEditingController();
  bool isError = false;

  void validateCode() {
    setState(() {
      isError = false; // Réinitialiser l'erreur

      // Simulation d'une validation
      if (codeController.text == "123456" && widget.role == "salon_owner") {
        // Redirection vers la page du coiffeur
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => AccountView()),
              (route) => false,
        );
      } else if (codeController.text == "789123" && widget.role == "customer") {
        // Redirection vers la page du client
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreeen()),
        );
      } else {
        // Afficher une erreur
        isError = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vérification du code")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Un code a été envoyé à ${widget.emailOrPhone}.",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                labelText: "Entrez le code",
                border: const OutlineInputBorder(),
                errorText: isError ? "Code invalide, essayez encore en tapant le code dédié à votre type de conmpte." : null,
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: validateCode,
              child: const Text("Valider le code"),
            ),
            TextButton(
              onPressed: () {
                // Simulation de renvoi de code
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Code renvoyé !")),
                );
              },
              child: const Text("Renvoyer un nouveau code"),
            ),
          ],
        ),
      ),
    );
  }
}
