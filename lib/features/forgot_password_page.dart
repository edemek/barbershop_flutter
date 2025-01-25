import 'package:flutter/material.dart';
import 'reset_password_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Réinitialiser le mot de passe")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Veuillez entrer votre adresse e-mail pour recevoir un lien de réinitialisation.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Adresse e-mail"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final String email = emailController.text;
                  // Simuler l'envoi d'un lien sécurisé
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Lien envoyé à votre adresse e-mail !"),
                    ),
                  );
                },
                child: const Text("Envoyer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
