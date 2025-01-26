import 'package:flutter/material.dart';
import 'dashboard/dashboard.dart';

class VerificationPage extends StatefulWidget {
  final String emailOrPhone;

  const VerificationPage( {required this.emailOrPhone, super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController codeController = TextEditingController();
  bool isError = false;

  void validateCode() {
    setState(() {
      isError = false; // Réinitialiser l'erreur

      // Simulation d'une validation (par exemple, un code correct est "123456")
      if (codeController.text == "123456") {
        // Redirection vers le tableau de bord
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) =>  DashboardPage()),
              (route) => false,
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
                errorText: isError ? "Code invalide, essayez encore." : null,
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
