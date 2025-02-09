import 'package:flutter/material.dart';

class PageScreenNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Rechercher un service...',
            border: InputBorder.none,
            icon: Icon(Icons.search),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Action pour le filtre
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Salons de Beauté',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Une coupe impeccable pour un début de journée éclatant',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Action pour le bouton
                    },
                    child: Text('Découvrir'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      side: BorderSide.none, // Suppression de la bordure
                    ),
                  ),


                  SizedBox(height: 16),
                  Text(
                    'Veuillez choisir votre adresse',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommandé pour vous',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Action pour "View All"
                    },
                    child: Text('Tout Afficher'),
                  ),
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                  leading: Icon(Icons.star, color: Colors.amber),
                  title: Text('Niveau Un'),
                  subtitle: Text('Blanc Beauty Smile Olson, Cummerata and Cormier\n0.00 km'),
                  trailing: Text('Fermé', style: TextStyle(color: Colors.red)),
                ),
                ListTile(
                  leading: Icon(Icons.star, color: Colors.amber),
                  title: Text('Niveau Un'),
                  subtitle: Text('testoooo\n0.00 km'),
                  trailing: Text('Fermé', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
