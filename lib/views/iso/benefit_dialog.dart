import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BenefitDialog extends StatefulWidget {
  final Function() onAdd;
  final TextEditingController benefitController;
  final String functionName;

  const BenefitDialog(
      {super.key,
      required this.onAdd,
      required this.benefitController,
      required this.functionName});

  @override
  State<BenefitDialog> createState() => BenefitDialogState();
}

class BenefitDialogState extends State<BenefitDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.functionName == 'add' ? 'Add Benefit' : 'Edit Benefit',
        style: TextStyle(fontSize: 14.r),
      ),
      titlePadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      content: TextFormField(
        controller: widget.benefitController,
        decoration: const InputDecoration(
          labelText: 'Benefit Title',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a benefit title';
          }
          return null;
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (widget.benefitController.text.isNotEmpty) {
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
