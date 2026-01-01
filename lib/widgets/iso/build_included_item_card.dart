import 'package:b2b_partnership_admin/models/iso_included_model.dart';
import 'package:flutter/material.dart';

Widget buildIncludedItemCard(int index, IsoIncludedModel item , void Function() onPressed) {
  return Card(
    margin: const EdgeInsets.only(bottom: 12),
    elevation: 1,
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.deepPurple.withOpacity(0.1),
        child: Text(
          '${index + 1}',
          style: const TextStyle(color: Colors.deepPurple),
        ),
      ),
      title: Text(
        item.title??'',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(item.description??''),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: onPressed
        //() {
          // setState(() {
          //   controller.includedItems.removeAt(index);
          // });
        //},
      ),
    ),
  );
}
