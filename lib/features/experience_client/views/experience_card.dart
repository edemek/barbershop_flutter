import 'package:flutter/material.dart';

class ExperienceCard extends StatelessWidget {
  final String beforeImage;
  final String afterImage;
  final String description;
  final String taggedSalon;
  final int likes;
  final VoidCallback onLike;

  const ExperienceCard({
    required this.beforeImage,
    required this.afterImage,
    required this.description,
    required this.taggedSalon,
    required this.likes,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📸 Affichage des images avant/après en mode côte à côte
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildImage(beforeImage),
                SizedBox(width: 10),
                _buildImage(afterImage),
              ],
            ),
            SizedBox(height: 10),
            // 📝 Description de l'expérience
            Text(
              description,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            // 🔖 Salon tagué
            Text(
              "Salon: $taggedSalon",
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey[600]),
            ),
            SizedBox(height: 10),
            // ❤️ Bouton like
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("$likes J'aime", style: TextStyle(fontSize: 14)),
                IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red),
                  onPressed: onLike,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(imageUrl, width: 100, height: 100, fit: BoxFit.cover),
    );
  }
}
