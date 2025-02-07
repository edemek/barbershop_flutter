import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart'; // Couleurs constantes utilisées dans l'application.
import '../curved_edges/curved_edges_widget.dart'; // Widget pour créer des bords incurvés.
import 'circular_container.dart'; // Widget pour afficher des conteneurs circulaires.

/// Un widget qui affiche un conteneur principal avec une couleur de fond,
/// des bords incurvés et des cercles décoratifs positionnés stratégiquement.
class TPrimaryHeaderContainer extends StatelessWidget {
  /// Le widget enfant à afficher dans le conteneur.
  final Widget child;

  const TPrimaryHeaderContainer({
    super.key,
    required this.child, // Le widget enfant est obligatoire.
  });

  @override
  Widget build(BuildContext context) {
    return TCurvedEdgesWidget(
      // Ce widget enveloppe le contenu pour ajouter des bords incurvés.
      child: Container(
        //color: TColors.blue, // Définit la couleur d'arrière-plan principale.
        padding: const EdgeInsets.all(0), // Aucun espacement interne.
        child: SizedBox(
          height: 400, // Définit la hauteur fixe du conteneur.
          child: Stack(
            // Utilisé pour superposer des widgets les uns sur les autres.
            children: [
              /// Cercle décoratif situé en haut à droite, en dehors des limites visibles.
              Positioned(
                top:
                    -150, // Positionne le cercle au-dessus de la limite visible.
                right:
                    -250, // Positionne le cercle à droite en dehors de l'écran.
                child: TCircularContainer(
                  // Conteneur circulaire avec une opacité réduite.
                  backgroundColor: TColors.textWhite.withOpacity(0.1),
                ),
              ),

              /// Cercle décoratif situé légèrement plus bas à droite.
              Positioned(
                top: 100, // Positionne le cercle plus bas que le premier.
                right: -300, // Positionne encore plus à droite.
                child: TCircularContainer(
                  backgroundColor: TColors.textWhite.withOpacity(0.1),
                ),
              ),

              /// Contenu principal du conteneur.
              child,
            ],
          ),
        ),
      ),
    );
  }
}
