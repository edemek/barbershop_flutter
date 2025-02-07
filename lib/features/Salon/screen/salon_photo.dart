import 'package:flutter/material.dart';

class SalonPhotos extends StatelessWidget {
  final List<String> imageUrls;

  SalonPhotos({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250, // Hauteur du carrousel
      child: PageView.builder(
        itemCount: imageUrls.length,
        pageSnapping: true, // Effet de défilement page par page
        controller: PageController(viewportFraction: 0.9), // Taille des images
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                //utilisation de NetworkImage(imageUrls[index])
                //Asset en cas de stockage en ligne
                image: AssetImage(imageUrls[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
