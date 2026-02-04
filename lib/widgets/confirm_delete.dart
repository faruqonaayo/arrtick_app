import 'package:flutter/material.dart';

class ConfirmDelete extends StatelessWidget {
  final String itemName;
  final String itemId;
  final void Function(String itemId) deleteFunction;

  const ConfirmDelete({
    super.key,
    required this.itemName,
    required this.itemId,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Delete $itemName',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
      content: Text(
        'Are you sure you want to delete "$itemName"? This action cannot be undone.',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            deleteFunction(itemId);
            Navigator.of(context).pop(true); // Close the dialog
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
