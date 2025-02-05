import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String, String) onSearch; // Callback pour envoyer les résultats de la recherche et du filtre

  const SearchBarWidget({Key? key, required this.onSearch}) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController _searchController = TextEditingController();
  String _selectedFilter = "Tous"; // Filtre par défaut

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Champ de texte pour la recherche
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Rechercher un salon ou un service...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: Icon(Icons.search), // Icône de loupe à gauche
              suffixIcon: PopupMenuButton<String>(
                icon: Icon(Icons.filter_list), // Icône de filtre
                onSelected: (String value) {
                  setState(() {
                    _selectedFilter = value; // Met à jour le filtre sélectionné
                  });
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(value: "Tous", child: Text("Tous")),
                  PopupMenuItem(value: "Skin", child: Text("Skin")),
                  PopupMenuItem(value: "Massage", child: Text("Massage")),
                  PopupMenuItem(value: "Makeup", child: Text("Makeup")),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 10), // Espacement entre le champ et le bouton
        // Bouton de recherche
        ElevatedButton(
          onPressed: () {
            widget.onSearch(_searchController.text, _selectedFilter);
          },
          child: Text("Rechercher"),
        ),
      ],
    );
  }
}
