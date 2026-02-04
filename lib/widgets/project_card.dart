import 'package:flutter/material.dart';

import 'package:arrtick_app/models/project.dart';
import 'package:arrtick_app/theme.dart';
import 'package:arrtick_app/util.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        leading: Icon(
          project.isFavorite ? Icons.star : Icons.star_border,
          color: project.isFavorite ? yellowColor : Colors.grey,
        ),
        title: Text(
          project.name,
          style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.description,
              style: textTheme.bodyMedium!.copyWith(
                overflow: TextOverflow.ellipsis,
                color: colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Deadline: ${formatDate(project.estimatedEndDate)}',
              style: textTheme.bodySmall!.copyWith(
                fontSize: 12,
                color: colorScheme.tertiary,
              ),
            ),
          ],
        ),

        trailing: project.isCompleted
            ? Icon(Icons.check_circle, color: Colors.greenAccent)
            : Icon(
                Icons.pending,
                color: Colors.orangeAccent.withValues(alpha: 0.7),
              ),

        onTap: () {
          // Handle project card tap if needed
        },
      ),
    );
  }
}
