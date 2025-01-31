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
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredReviews = selectedRating > 0
        ? reviews.where((r) => r["rating"] == selectedRating).toList()
        : reviews;

    return Column(
      children: [
        DropdownButton<int>(
          value: selectedRating,
          onChanged: (value) => setState(() => selectedRating = value!),
          items: [0, 1, 2, 3, 4, 5]
              .map((num) => DropdownMenuItem(value: num, child: Text(num == 0 ? "Tous" : "$num ⭐")))
              .toList(),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredReviews.length,
            itemBuilder: (context, index) {
              final review = filteredReviews[index];
              return ListTile(
                title: Text("${review["name"]} - ${"⭐" * review["rating"]}"),
                subtitle: Text(review["comment"]),
              );
            },
          ),
        ),
      ],
    );
  }
}
