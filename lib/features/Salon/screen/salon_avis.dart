import 'package:flutter/material.dart';

class SalonReviews extends StatefulWidget {
  @override
  _SalonReviewsState createState() => _SalonReviewsState();
}

class _SalonReviewsState extends State<SalonReviews> {
  int selectedRating = 0; // Pour filtrer par note
  List<Map<String, dynamic>> reviews = [
    {"name": "Alice", "rating": 5, "comment": "Super salon!"},
    {"name": "Bob", "rating": 3, "comment": "Correct, sans plus."},
    {"name": "Charlie", "rating": 4, "comment": "Très bien, je reviendrai."},
    {"name": "David", "rating": 2, "comment": "Décevant, à revoir."},
    // Ajouter plus de critiques pour tester
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredReviews = selectedRating > 0
        ? reviews.where((r) => r["rating"] == selectedRating).toList()
        : reviews;

    return Scaffold(
      appBar: AppBar(
        title: Text("Reviews & Ratings"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: DropdownButton<int>(
              value: selectedRating,
              onChanged: (value) => setState(() => selectedRating = value!),
              items: [0, 1, 2, 3, 4, 5]
                  .map((num) => DropdownMenuItem(
                value: num,
                child: Text(num == 0 ? "Tous" : "$num ⭐"),
              ))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Avis (${filteredReviews.length})",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          // Envelopper le ListView dans un Expanded ou une hauteur fixe
          Expanded(
            child: filteredReviews.isEmpty
                ? Center(child: Text("Aucun avis trouvé"))
                : ListView.builder(
              itemCount: filteredReviews.length,
              itemBuilder: (context, index) {
                final review = filteredReviews[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      "${review["name"]} - ${"⭐" * review["rating"]}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(review["comment"]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
