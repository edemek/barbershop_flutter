import 'package:flutter/material.dart';
import 'salon_details.dart';

class SalonListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> salonsList = [
    {
      "name": "Salon Prestige",
      "address": "123 Avenue des Coiffeurs, Lomé",
      "openingHours": "08:00 - 20:00",
      "imageUrls": ["assets/images/photo_salon/s (7).jpg","assets/images/photo_salon/s (6).jpg"],
      "phone": "+228 90 00 00 01",
      "email": "contact@salonprestige.com",
      "latitude": 6.1319,
      "longitude": 1.2228,
    },
    {
      "name": "Barber King",
      "address": "456 Rue Royale, Lomé",
      "openingHours": "09:00 - 21:00",
      "imageUrls": ["assets/images/photo_salon/s (1).jpg","assets/images/photo_salon/s (4).jpg"],
      "phone": "+228 90 00 00 02",
      "email": "info@barberking.com",
      "latitude": 6.1724,
      "longitude": 1.2085,
    }
  ];


  // Définition des couleurs personnalisées
  static const Color goldColor = Color(0xFFD4AF37);
  static const Color lightBlack = Color(0xFF333333);
  static const Color accentBlue = Color(0xFF1E3799);


  



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Liste des salons",
          style: TextStyle(
            color: lightBlack,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
    leading:
         Icon(Icons.sort),
        iconTheme: IconThemeData(color: lightBlack),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: salonsList.length,
        itemBuilder: (context, index) {
          final salon = salonsList[index];
          return Container(
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SalonDetails(
                          salonName: salon["name"],
                          salonDescription: salon["address"],
                          salonImages: List<String>.from(salon["imageUrls"]),
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image du salon
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        child: salon["imageUrls"].isNotEmpty
                            ? Image.asset(
                          salon["imageUrls"][0],
                          fit: BoxFit.cover,
                        )
                            : Icon(
                          Icons.store_mall_directory,
                          size: 60,
                          color: lightBlack,
                        ),
                      ),
                      // Informations du salon
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              salon["name"],
                              style: TextStyle(
                                color: lightBlack,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    color: goldColor,
                                    size: 16),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    salon["address"],
                                    style: TextStyle(
                                      color: lightBlack.withOpacity(0.7),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.access_time,
                                    color: accentBlue,
                                    size: 16),
                                SizedBox(width: 4),
                                Text(
                                  salon["openingHours"],
                                  style: TextStyle(
                                    color: lightBlack.withOpacity(0.7),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}