import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Category> categories = [
    Category(
      name: "Skin",
      icon: Icons.medical_services_outlined,
      color: Colors.red.shade100,
      iconColor: Colors.red,
      services: [],
    ),
    Category(
      name: "Massage",
      icon: Icons.spa_outlined,
      color: Colors.purple.shade100,
      iconColor: Colors.purple,
      services: ["Spa", "Braid"],
    ),
    Category(
      name: "Makeup",
      icon: Icons.brush_outlined,
      color: Colors.orange.shade100,
      iconColor: Colors.orange,
      services: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          "Categories",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBar(),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryTile(category: categories[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return

        /// Bar de recherche
        TextFormField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Iconsax.search_normal),
        labelText: 'Rechercher un service...',
        suffixIcon: PopupMenuButton<String>(
          icon: const Icon(Icons.filter_list), // Icône de filtre
          onSelected: (String value) {
            // Action de filtre
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem(
                value: "Tous", child: Text("Tous les services")),
            const PopupMenuItem(value: "Coupes", child: Text("Coupes")),
            const PopupMenuItem(value: "Tresses", child: Text("Tresses")),
            const PopupMenuItem(value: "Massage", child: Text("Massage")),
            const PopupMenuItem(value: "Makeup", child: Text("Makeup")),
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final Category category;

  CategoryTile({required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: category.color,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        leading: Icon(category.icon, color: category.iconColor),
        title: Text(
          category.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: category.services
            .map((service) => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(service, style: TextStyle(fontSize: 16)),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class Category {
  final String name;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final List<String> services;

  Category({
    required this.name,
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.services,
  });
}
