import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddOptions extends StatelessWidget {
  const AddOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      height: 300,
      child: Center(
        child: Column(
          spacing: 4,
          children: [
            Text(
              'Add Options',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.folder_outlined),
              title: Text('Add new project'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                // Handle add new project action by going to the add project screen
                Navigator.of(context).pop(); // Close the bottom sheet
                context.push("/project/new");
              },
            ),
            ListTile(
              leading: Icon(Icons.task_outlined),
              title: Text('Add new task'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                // Handle add new task action
              },
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
