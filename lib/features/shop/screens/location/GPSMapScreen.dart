import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionPage extends StatefulWidget {
  const PermissionPage({super.key});

  @override
  _PermissionPageState createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  String location = "Position inconnue";

  Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage, // Pour accès aux fichiers (Android < 10)
      Permission.photos,  // Pour iOS (accès à la galerie)
      Permission.location
    ].request();

    if (statuses[Permission.location] == PermissionStatus.granted) {
      getCurrentLocation();
    }
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => location = "Service de localisation désactivé");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => location = "Permission refusée");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => location =
      "Permission refusée définitivement. Activez-la dans les paramètres.");
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() => location = "Lat: ${position.latitude}, Lng: ${position.longitude}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gestion des permissions")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(location, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: requestPermissions,
              child: const Text("Demander les permissions"),
            ),
          ],
        ),
      ),
    );
  }
}


