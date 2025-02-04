import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RatingView extends StatelessWidget {
  final String salonName;
  final String salonImageUrl;
  final RxDouble rating = 0.0.obs;
  final TextEditingController reviewController = TextEditingController();

  // Construction avec salonName et salonImageUrl comme paramètres
  RatingView({
    required this.salonName,
    required this.salonImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Laisser un Avis"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            Get.snackbar("Avis soumis", "Merci pour votre avis !");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Get.theme.colorScheme.secondary,
            padding: EdgeInsets.symmetric(vertical: 12),
          ),
          child: Text(
            "Soumettre l'Avis",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: CachedNetworkImage(
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: salonImageUrl,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  salonName,  // Le nom du salon ici
                  style: Get.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text("Cliquez sur les étoiles pour noter ce salon"),
                SizedBox(height: 10),
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < rating.value ? Icons.star : Icons.star_border,
                        size: 40,
                        color: Colors.orange,
                      ),
                      onPressed: () {
                        rating.value = index + 1.0;
                      },
                    );
                  }),
                )),
                SizedBox(height: 20),
              ],
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: reviewController,
            decoration: InputDecoration(
              labelText: "Écrire un avis",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.description),
            ),
          ),
        ],
      ),
    );
  }
}
