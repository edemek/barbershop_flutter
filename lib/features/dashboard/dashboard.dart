import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section de statistiques
            Text(
              'Bienvenue dans votre tableau de bord',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Cartes statistiques
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard('Utilisateurs', '150', Colors.blue),
                _buildStatCard('Ventes', '1200', Colors.green),
              ],
            ),
            SizedBox(height: 20),

            // Liste de navigation vers des actions (ajouter/modifier)
            Text('Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListTile(
              title: Text('Gérer les utilisateurs'),
              onTap: () {
                // Naviguer vers une autre page
              },
            ),
            ListTile(
              title: Text('Voir les ventes'),
              onTap: () {
                // Naviguer vers une autre page
              },
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour construire une carte statistique
  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      color: color.withOpacity(0.1),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
