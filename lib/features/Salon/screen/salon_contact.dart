import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SalonContact extends StatelessWidget {
  final String phoneNumber;
  final String email;

  SalonContact({required this.phoneNumber, required this.email});

  void _call() => launchUrl(Uri.parse("tel:$phoneNumber"));
  void _email() => launchUrl(Uri.parse("mailto:$email"));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(icon: Icon(Icons.phone), label: Text("Appeler"), onPressed: _call),
        ElevatedButton.icon(icon: Icon(Icons.email), label: Text("Envoyer un email"), onPressed: _email),
      ],
    );
  }
}
