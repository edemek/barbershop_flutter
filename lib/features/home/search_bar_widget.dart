import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String, String) onSearch;
  final Function(String) onSortChange;

  const SearchBarWidget({
    Key? key,
    required this.onSearch,
    required this.onSortChange,
  }) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController _searchController = TextEditingController();
  String _selectedFilter = "Tous";
  String _sortBy = "distance";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Rechercher un salon...",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(width: 10),
            PopupMenuButton<String>(
              icon: Icon(Icons.filter_list),
              onSelected: (value) => setState(() {
                _selectedFilter = value;
                widget.onSearch(_searchController.text, _selectedFilter);
              }),
              itemBuilder: (context) => [
                PopupMenuItem(value: "Tous", child: Text("Tous")),
                PopupMenuItem(value: "Skin", child: Text("Skin")),
                PopupMenuItem(value: "Massage", child: Text("Massage")),
                PopupMenuItem(value: "Makeup", child: Text("Makeup")),
              ],
            ),
            SizedBox(width: 10),
            PopupMenuButton<String>(
              icon: Icon(Icons.sort),
              onSelected: (value) => setState(() {
                _sortBy = value;
                widget.onSortChange(_sortBy);
              }),
              itemBuilder: (context) => [
                PopupMenuItem(value: "distance", child: Text("Trier par Distance")),
                PopupMenuItem(value: "note", child: Text("Trier par Note")),
                PopupMenuItem(value: "prix", child: Text("Trier par Prix")),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
