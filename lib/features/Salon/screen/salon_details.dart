import 'package:flutter/material.dart';
import '../../rating/rating_view.dart';
import 'salon_avis.dart';
import 'salon_photo.dart';

class SalonDetails extends StatelessWidget {
  // Définition des couleurs principales
  static const Color primaryGold = Color(0xFFDAA520);
  static const Color backgroundBlack = Color(0xFF1A1A1A);
  static const Color softWhite = Color(0xFFF5F5F5);
  static const Color darkGrey = Color(0xFF2A2A2A);

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
      backgroundColor: backgroundBlack,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkGrey,
        iconTheme: IconThemeData(color: softWhite),
        title: Text(
          salonName,
          style: TextStyle(
            color: softWhite,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              child: salonImages.isNotEmpty
                  ? SalonPhotos(imageUrls: salonImages)
                  : Container(
                color: darkGrey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: primaryGold,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Aucune image disponible",
                        style: TextStyle(
                          color: softWhite.withOpacity(0.7),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [darkGrey, backgroundBlack],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    salonName,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: softWhite,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    salonDescription,
                    style: TextStyle(
                      fontSize: 16,
                      color: softWhite.withOpacity(0.8),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Nos Services",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: softWhite,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildServiceCard("Coupe Homme", "À partir de 500F", Icons.content_cut),
                  _buildServiceCard("Barbe", "À partir de 150F", Icons.face),
                  _buildServiceCard("Coloration", "À partir de 2000F", Icons.color_lens),
                  SizedBox(height: 32),

                  // Section des avis
                  Container(
                    height: 300,
                    child: SalonReviews(),
                  ),

                  // Bouton pour donner un avis
                  _buildStyledButton(
                    text: "Donner un avis",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RatingView(
                            salonName: salonName,
                            salonImageUrl: salonImages.isNotEmpty ? salonImages[0] : '',
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 16),

                  // Bouton de réservation
                  _buildStyledButton(
                    text: "Réserver maintenant",
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Réservation effectuée avec succès (test)"),
                          backgroundColor: primaryGold,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(String name, String price, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: darkGrey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: primaryGold.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: backgroundBlack,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: primaryGold, width: 1.5),
            ),
            child: Icon(icon, color: primaryGold, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16,
                color: softWhite,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: 16,
              color: primaryGold,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStyledButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: primaryGold.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGold,
          foregroundColor: backgroundBlack,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: backgroundBlack,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}