import 'package:flutter/material.dart';

Widget buildSectionHeader(String title, VoidCallback onAdd) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          // color: Colors.deepPurple,
        ),
      ),
      IconButton(
        onPressed: onAdd,
        icon: const Icon(Icons.add_circle),
        color: Colors.deepPurple,
        iconSize: 28,
      ),
    ],
  );
}
