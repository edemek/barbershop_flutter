import 'package:flutter/material.dart';
import 'experienceListPage.dart';
import 'experience_card.dart';

class ExperienceList extends StatelessWidget {
  // Liste fictive d'expériences (remplace-la par une source de données réelle)
  final List<Map<String, dynamic>> experiences = [
    {
      "beforeImage": "https://quefairealome.com/wp-content/uploads/2021/10/photo_2021-10-07_17-24-57.jpg", // Remplace par un lien d'image réel
      "afterImage": "https://quefairealome.com/wp-content/uploads/2022/07/R.jpg",
      "description": "Super transformation capillaire chez Salon BelleVie !",
      "taggedSalon": "Salon BelleVie",
      "likes": 25,
    },

    {
      "beforeImage": "https://scontent.flfw5-1.fna.fbcdn.net/v/t39.30808-6/448561869_1606705310123692_4072039853538736452_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_ohc=QNcIbKMWROsQ7kNvgGx-YjF&_nc_zt=23&_nc_ht=scontent.flfw5-1.fna&_nc_gid=AfOsgYIiVD1GkCo2lx6bZMr&oh=00_AYBi8PYfxvy1EOVFjpMst-tom7ZavGTC-uuRU_XEKkKELA&oe=67A50B04",
      "afterImage": "https://quefairealome.com/wp-content/uploads/2022/07/photo_2022-07-14_18-15-46.jpg",
      "description": "Nouvelle coloration, j'adore !",
      "taggedSalon": "Coloration Pro",
      "likes": 55,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expériences des autres utilisateurs"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: experiences.length, // Nombre d'expériences à afficher
        itemBuilder: (context, index) {
          final experience = experiences[index]; // Récupération de chaque expérience

          return ExperienceCard(
            beforeImage: experience["beforeImage"],
            afterImage: experience["afterImage"],
            description: experience["description"],
            taggedSalon: experience["taggedSalon"],
            likes: experience["likes"],
            onLike: () {
              // 🖤 Fonction appelée lorsqu'on appuie sur le bouton "J'aime"
              print("J'aime ajouté à ${experience['taggedSalon']}");
              ExperienceListPage();
            },
          );
        },

      ),


    );

  }

}

