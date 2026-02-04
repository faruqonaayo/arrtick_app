import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:arrtick_app/util.dart';
import 'package:arrtick_app/providers/project_provider.dart';

class ProjectDetails extends ConsumerWidget {
  final String projectId;

  const ProjectDetails({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final project = ref
        .watch(projectProvider)
        .firstWhere((p) => p.id == projectId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              project.isFavorite ? Icons.star : Icons.star_border,
              color: project.isFavorite ? Colors.amber : Colors.grey,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            project.name,
            style: textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: project.isCompleted
                  ? Colors.greenAccent.withValues(alpha: 0.2)
                  : Colors.orangeAccent.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              project.isCompleted ? 'Completed' : 'In Progress',
              style: textTheme.bodyMedium!.copyWith(
                color: project.isCompleted
                    ? Colors.greenAccent.withValues(alpha: 0.8)
                    : Colors.orangeAccent.withValues(alpha: 0.8),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildStartAndEndDateRow(
            context,
            project.startDate,
            project.estimatedEndDate,
          ),
          const SizedBox(height: 32),
          Text(
            'Description',
            style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            project.description,
            style: textTheme.bodyMedium!.copyWith(color: colorScheme.secondary),
          ),

          const SizedBox(height: 32),
          Text(
            'Tasks',
            style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildStartEndDateColumn(
    BuildContext context,
    String label,
    DateTime date,
    Color color,
  ) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(formatDate(date)),
        ],
      ),
    );
  }

  Widget _buildStartAndEndDateRow(
    BuildContext context,
    DateTime start,
    DateTime end,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStartEndDateColumn(
          context,
          'Start Date',
          start,
          colorScheme.primary,
        ),
        const SizedBox(width: 32),
        _buildStartEndDateColumn(
          context,
          'Est End Date',
          end,
          colorScheme.error,
        ),
      ],
    );
  }
}
