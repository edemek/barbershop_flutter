import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportClientPage extends StatelessWidget {
  // Adresse email pour le support client
  final String supportEmail = "urbainbalogou19@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Support Client"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Besoin d'aide ? Contactez notre support client.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Lien mailto pour ouvrir l'application email
                final Uri emailUri = Uri(
                  scheme: 'mailto',
                  path: supportEmail,
                  query: 'subject=Support Client&body=Bonjour,', // Préremplir sujet et corps
                );

                if (await canLaunchUrl(emailUri)) {
                  await launchUrl(emailUri);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Impossible d'ouvrir l'application email."),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Écrire à notre support",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
