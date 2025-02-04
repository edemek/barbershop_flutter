import 'package:flutter/material.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Créer un nouveau mot de passe")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Créez un nouveau mot de passe",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Nouveau mot de passe"),
              ),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Confirmer le mot de passe"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (newPasswordController.text == confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Mot de passe réinitialisé avec succès !")),
                    );
                    Navigator.pop(context); // Retour à la connexion
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Les mots de passe ne correspondent pas.")),
                    );
                  }
                },
                child: const Text("Réinitialiser"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
