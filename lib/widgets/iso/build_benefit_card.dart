import 'package:flutter/material.dart';

Widget buildBenefitCard( String benefit , void Function() onPressed ) {
  return Card(
    margin: const EdgeInsets.only(bottom: 12),
    elevation: 1,
    child: ListTile(
      leading: const Icon(Icons.check_circle, color: Colors.green),
      title: Text(benefit),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: onPressed
        // () {
        //   setState(() {
        //     controller.benefits.removeAt(index);
        //   });
        // },
      ),
    ),
  );
}
