import 'package:flutter/material.dart';

// Widget principal avec état pour gérer la liste des services
class ManageServicesPage extends StatefulWidget {
  @override
  _ManageServicesPageState createState() => _ManageServicesPageState();
}

class _ManageServicesPageState extends State<ManageServicesPage> {
  // Liste de services pré-remplie avec des données fictives
  // Chaque service contient un nom, une description, un prix, une durée et une couleur
  List<Map<String, dynamic>> services = [
    {
      'name': 'Massage relaxant',
      'description': 'Un massage apaisant pour détendre le corps et l\'esprit',
      'price': 45000,
      'duration': 60,
      'color': Colors.blue[100] // Couleur de fond pastel pour la carte
    },
    {
      'name': 'Soin du visage',
      'description': 'Nettoyage profond et masque hydratant',
      'price': 35000,
      'duration': 45,
      'color': Colors.green[100]
    },
    {
      'name': 'Manucure premium',
      'description': 'Soin complet des mains avec pose de vernis',
      'price': 25000,
      'duration': 30,
      'color': Colors.purple[100]
    },
  ];

  // Méthode pour ajouter un nouveau service
  void _addService(Map<String, dynamic> newService) {
    setState(() {
      // Liste de couleurs pastel pour les nouvelles cartes
      final colors = [
        Colors.blue[100],
        Colors.green[100],
        Colors.purple[100],
        Colors.orange[100],
        Colors.pink[100]
      ];
      // Attribution cyclique des couleurs
      newService['color'] = colors[services.length % colors.length];
      services.add(newService);
    });
    _showNotification('Service ajouté avec succès.');
  }

  // Méthode pour modifier un service existant
  void _editService(int index, Map<String, dynamic> updatedService) {
    setState(() {
      // Conservation de la couleur d'origine lors de la modification
      updatedService['color'] = services[index]['color'];
      services[index] = updatedService;
    });
    _showNotification('Service modifié avec succès.');
  }

  // Méthode pour supprimer un service avec confirmation
  void _deleteService(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmer la suppression'),
        content: Text('Voulez-vous vraiment supprimer ce service ?'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Bords arrondis pour la boîte de dialogue
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                services.removeAt(index);
              });
              Navigator.pop(context);
              _showNotification('Service supprimé avec succès.');
            },
            child: Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // Méthode pour afficher les notifications flottantes
  void _showNotification(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating, // Style flottant pour la notification
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gérer mes services'),
        elevation: 0, // Suppression de l'ombre de l'AppBar
      ),
      body: Column(
        children: [
          // Zone principale avec grille de services
          Expanded(
            child: services.isEmpty
            // Affichage d'un message si aucun service n'est disponible
                ? Center(
              child: Text(
                'Aucun service disponible.\nAjoutez votre premier service !',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            )
            // Grille de services avec 2 colonnes
                : GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 cartes par ligne
                childAspectRatio: 0.85, // Rapport hauteur/largeur des cartes
                crossAxisSpacing: 16, // Espacement horizontal
                mainAxisSpacing: 16, // Espacement vertical
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                // Carte de service personnalisée
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: service['color'],
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // En-tête de la carte avec nom et menu
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                service['name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // Menu contextuel pour modifier/supprimer
                            PopupMenuButton(
                              icon: Icon(Icons.more_vert),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit, color: Colors.blue),
                                      SizedBox(width: 8),
                                      Text('Modifier'),
                                    ],
                                  ),
                                  onTap: () {
                                    // Délai nécessaire pour la fermeture du menu
                                    Future.delayed(
                                      Duration(seconds: 0),
                                          () => _openServiceForm(
                                        service: service,
                                        onSave: (updatedService) =>
                                            _editService(index, updatedService),
                                      ),
                                    );
                                  },
                                ),
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete, color: Colors.red),
                                      SizedBox(width: 8),
                                      Text('Supprimer'),
                                    ],
                                  ),
                                  onTap: () {
                                    Future.delayed(
                                      Duration(seconds: 0),
                                          () => _deleteService(index),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        // Zone de description avec limitation de lignes
                        Expanded(
                          child: Text(
                            service['description'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Divider(),
                        // Pied de carte avec prix et durée
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${service['price']} F',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              '${service['duration']} min',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Bouton d'ajout de service en bas de l'écran
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                _openServiceForm(
                  onSave: _addService,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Bouton arrondi
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 8),
                  Text('Ajouter un service'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Méthode pour ouvrir le formulaire d'ajout/modification de service
  void _openServiceForm({Map<String, dynamic>? service, required Function(Map<String, dynamic>) onSave}) {
    // Contrôleurs pour les champs de texte
    final nameController = TextEditingController(text: service?['name']);
    final descriptionController = TextEditingController(text: service?['description']);
    final priceController = TextEditingController(text: service?['price']?.toString());
    final durationController = TextEditingController(text: service?['duration']?.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(service == null ? 'Ajouter un service' : 'Modifier le service'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Champ nom du service
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Nom du service',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Champ description
                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Champ prix
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText: 'Prix',
                    suffixText: 'F',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                // Champ durée
                TextField(
                  controller: durationController,
                  decoration: InputDecoration(
                    labelText: 'Durée',
                    suffixText: 'min',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                // Validation des champs obligatoires
                if (nameController.text.isEmpty ||
                    descriptionController.text.isEmpty ||
                    priceController.text.isEmpty ||
                    durationController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Veuillez remplir tous les champs'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                final newService = {
                  'name': nameController.text,
                  'description': descriptionController.text,
                  'price': int.parse(priceController.text),
                  'duration': int.parse(durationController.text),
                };
                onSave(newService);
                Navigator.pop(context);
              },
              child: Text('Sauvegarder'),
            ),
          ],
        );
      },
    );
  }
}