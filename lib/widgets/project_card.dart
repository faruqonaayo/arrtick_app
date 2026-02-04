import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:arrtick_app/providers/project_provider.dart';
import 'package:arrtick_app/widgets/confirm_delete.dart';
import 'package:arrtick_app/models/project.dart';
import 'package:arrtick_app/theme.dart';
import 'package:arrtick_app/util.dart';

class ProjectCard extends ConsumerWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final projectNotifier = ref.read(projectProvider.notifier);

    return Dismissible(
      key: ValueKey(project.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        final response = await showDialog(
          context: context,
          builder: (ctx) => ConfirmDelete(
            itemName: project.name,
            itemId: project.id,
            deleteFunction: projectNotifier.deleteProject,
          ),
        );
        return response;
      },
      child: Card(
        elevation: 0,
        color: colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
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
            // Handle project card tap to go to project details
            context.push('/project/${project.id}');
          },
        ),
      ),
    );
  }
}
