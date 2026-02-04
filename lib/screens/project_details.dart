import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:arrtick_app/models/project.dart';
import 'package:arrtick_app/util.dart';
import 'package:arrtick_app/providers/project_provider.dart';

class ProjectDetails extends ConsumerStatefulWidget {
  final String projectId;

  const ProjectDetails({super.key, required this.projectId});

  @override
  ConsumerState<ProjectDetails> createState() {
    return _ProjectDetailsState();
  }
}

class _ProjectDetailsState extends ConsumerState<ProjectDetails> {
  late String _projectId;
  late Project? _project;
  late bool _isFavorite;
  late ProjectNotifier _projectNotifier;

  @override
  void initState() {
    super.initState();
    _projectNotifier = ref.read(projectProvider.notifier);
    _project = _projectNotifier.getProjectById(widget.projectId);
    _isFavorite = _project?.isFavorite ?? false;
    _projectId = widget.projectId;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return _project == null
        ? Scaffold(
            appBar: AppBar(title: const Text('Project Details')),
            body: const Center(child: Text('Project not found.')),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Project Details'),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                      _projectNotifier.toggleFavoriteStatus(_projectId);
                    });
                  },
                  icon: Icon(
                    _isFavorite ? Icons.star : Icons.star_border,
                    color: _isFavorite ? Colors.amber : Colors.grey,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // wait for the edit screen to return
                    context.push('/project/edit/$_projectId');
                  },
                  icon: Icon(Icons.edit_outlined),
                ),
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text(
                  _project!.name,
                  style: textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _project!.isCompleted
                        ? Colors.greenAccent.withValues(alpha: 0.2)
                        : Colors.orangeAccent.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    _project!.isCompleted ? 'Completed' : 'In Progress',
                    style: textTheme.bodyMedium!.copyWith(
                      color: _project!.isCompleted
                          ? Colors.greenAccent.withValues(alpha: 0.8)
                          : Colors.orangeAccent.withValues(alpha: 0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildStartAndEndDateRow(
                  context,
                  _project!.startDate,
                  _project!.estimatedEndDate,
                ),
                const SizedBox(height: 32),
                Text(
                  'Description',
                  style: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _project!.description,
                  style: textTheme.bodyMedium!.copyWith(
                    color: colorScheme.secondary,
                  ),
                ),

                const SizedBox(height: 32),
                Text(
                  'Tasks',
                  style: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
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
