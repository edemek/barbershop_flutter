import 'package:barbershpo_flutter/features/Salon/screen/salon_photo.dart';
import 'package:flutter/material.dart';

class SalonDetails extends StatelessWidget {
  // Définition des couleurs personnalisées pour maintenir la cohérence avec l'écran précédent
  static const Color goldColor = Color(0xFFD4AF37);
  static const Color lightBlack = Color(0xFF333333);
  static const Color accentBlue = Color(0xFF1E3799);

  // Propriétés requises pour l'affichage des détails du salon
  final String salonName;
  final List<String> salonImages;
  final String salonDescription;

  const SalonDetails({
    Key? key,
    required this.salonName,
    required this.salonImages,
    required this.salonDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Configuration de l'arrière-plan en blanc pour un look épuré
      backgroundColor: Colors.white,

      // AppBar personnalisée avec un style moderne
      appBar: AppBar(
        elevation: 0, // Suppression de l'ombre
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: lightBlack),
        title: Text(
          salonName,
          style: TextStyle(
            color: lightBlack,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      // Contenu principal avec défilement
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section des photos avec gestion des cas où il n'y a pas d'images
            Container(
              height: 300, // Hauteur augmentée pour de meilleures proportions
              child: salonImages.isNotEmpty
                  ? SalonPhotos(imageUrls: salonImages)
                  : Container(
                color: Colors.grey[100],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: lightBlack.withOpacity(0.5),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Aucune image disponible",
                        style: TextStyle(
                          color: lightBlack.withOpacity(0.7),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Section des informations détaillées
            Container(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nom du salon avec style élégant
                  Text(
                    salonName,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: lightBlack,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Description du salon
                  Text(
                    salonDescription,
                    style: TextStyle(
                      fontSize: 16,
                      color: lightBlack.withOpacity(0.8),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 24),

                  // Section des services (à titre d'exemple)
                  Text(
                    "Nos Services",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: lightBlack,
                    ),
                  ),
                  SizedBox(height: 16),
                  // TODO apiservice
                  // Liste des services avec style élégant
                  _buildServiceCard("Coupe Homme", "À partir de 500F", Icons.content_cut),
                  _buildServiceCard("Barbe", "À partir de 150F", Icons.face),
                  _buildServiceCard("Coloration", "À partir de 2000F", Icons.color_lens),

                  SizedBox(height: 32),

                  // Bouton de réservation avec style sophistiqué
                  Container(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        // Action de réservation à implémenter
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: goldColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "Réserver maintenant",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget personnalisé pour afficher un service
  Widget _buildServiceCard(String name, String price, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: accentBlue, size: 24),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16,
                color: lightBlack,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: 16,
              color: goldColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}