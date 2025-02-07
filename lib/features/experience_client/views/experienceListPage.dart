import 'package:flutter/material.dart';
import 'experience_card.dart';
import 'dart:io';

class ExperienceListPage extends StatelessWidget {
  static final List<Map<String, dynamic>> experiences = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expériences partagées"),
        backgroundColor: Colors.black,
      ),
      body: experiences.isEmpty
          ? Center(child: Text(""))
          : ListView.builder(
        itemCount: experiences.length,
        itemBuilder: (context, index) {
          final exp = experiences[index];
          return ExperienceCard(
            beforeImage: (exp["beforeImage"] as File).path,
            afterImage: (exp["afterImage"] as File).path,
            description: exp["description"],
            taggedSalon: exp["taggedSalon"],
            likes: 0,
            onLike: () {},
          );
        },
      ),
    );
  }
}
