import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:arrtick_app/widgets/confirm_delete.dart';
import 'package:arrtick_app/models/project.dart';
import 'package:arrtick_app/models/task.dart';
import 'package:arrtick_app/providers/task_provider.dart';
import 'package:arrtick_app/util.dart';

class ProjectTasks extends ConsumerStatefulWidget {
  final Project project;
  const ProjectTasks({super.key, required this.project});

  @override
  ConsumerState<ProjectTasks> createState() {
    return _ProjectTasksState();
  }
}

class _ProjectTasksState extends ConsumerState<ProjectTasks> {
  late TaskNotifier _taskNotifier;
  late List<Task> _projectTasks;

  @override
  void initState() {
    super.initState();
    _taskNotifier = ref.read(taskProvider.notifier);
    _projectTasks = _taskNotifier.getTasksByProjectId(widget.project.id);
  }

  @override
  Widget build(BuildContext context) {
    final pendingTasks = _projectTasks
        .where((task) => !task.isChecked)
        .toList();

    final completedTasks = _projectTasks
        .where((task) => task.isChecked)
        .toList();

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(
                text: "Pending Tasks",
                icon: Icon(Icons.pending, color: Colors.orange),
              ),
              Tab(
                text: "Completed Tasks",
                icon: Icon(Icons.check_circle, color: Colors.green),
              ),
            ],
          ),
          SizedBox(
            height: 400, // Adjust height as needed
            child: TabBarView(
              children: [
                // Pending Tasks Tab
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: pendingTasks.length,
                  itemBuilder: (context, index) {
                    final task = pendingTasks[index];
                    return _buildTaskItem(
                      task,
                      onToggle: () {
                        setState(() {
                          _projectTasks = _taskNotifier.toggleTaskCompletion(
                            task.id,
                            widget.project.id,
                          );
                        });
                      },
                      toggleColor: Colors.orange,
                    );
                  },
                ),
                // Completed Tasks Tab
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: completedTasks.length,
                  itemBuilder: (context, index) {
                    final task = completedTasks[index];
                    return _buildTaskItem(
                      task,
                      onToggle: () {
                        setState(() {
                          _projectTasks = _taskNotifier.toggleTaskCompletion(
                            task.id,
                            widget.project.id,
                          );
                        });
                      },
                      toggleColor: Colors.green,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(
    Task task, {
    required Function onToggle,
    required Color toggleColor,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              toggleColor.withValues(alpha: 0.04),
              toggleColor.withValues(alpha: 0.08),
            ],
          ),
        ),

        child: ListTile(
          leading: IconButton(
            onPressed: () => onToggle(),
            icon: Icon(Icons.check_circle_outline, color: toggleColor),
          ),
          title: Text(
            task.title,
            style: textTheme.titleMedium!.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                task.note,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Date: ${formatDate(task.startDate)} | Time: ${task.startTime} - ${task.endTime}",
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.tertiary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              IconButton(
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (ctx) => ConfirmDelete(
                      itemName: task.title,
                      itemId: task.id,
                      deleteFunction: (itemId) {
                        _taskNotifier.deleteTask(itemId);
                      },
                    ),
                  );
                  setState(() {
                    _projectTasks = _taskNotifier.getTasksByProjectId(
                      widget.project.id,
                    );
                  });
                },
                icon: Icon(Icons.delete, color: Colors.redAccent, size: 16),
              ),
            ],
          ),
          trailing: Text(
            task.priority,
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
