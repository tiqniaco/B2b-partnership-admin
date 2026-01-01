import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IncludedItemDialog extends StatefulWidget {
  final Function() onAdd;
  final String functionName;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  const IncludedItemDialog(
      {super.key,
      required this.onAdd,
      required this.titleController,
      required this.descriptionController,
      required this.functionName});

  @override
  State<IncludedItemDialog> createState() => IncludedItemDialogState();
}

class IncludedItemDialogState extends State<IncludedItemDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.functionName == 'add'
            ? 'Add Included Item'
            : 'Edit Included Item',
        style: TextStyle(fontSize: 14.r),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: widget.titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: widget.descriptionController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (widget.titleController.text.isNotEmpty &&
                widget.descriptionController.text.isNotEmpty) {
              widget.onAdd();
              Navigator.pop(context);
            }
          },
          child: Text(widget.functionName == 'add' ? 'Add' : 'Edit'),
        ),
      ],
    );
  }
}
