import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:arrtick_app/models/task.dart';
import 'package:arrtick_app/models/task_priority.dart';

class TaskNotifier extends Notifier<List<Task>> {
  @override
  List<Task> build() {
    return sortTaskOptimally(_dummyTasks);
  }

  void addTask(Task task) {
    state = sortTaskOptimally([...state, task]);
  }

  List<Task> getTasksByProjectId(String projectId) {
    return state.where((task) => task.projectId == projectId).toList();
  }

  void deleteTask(String taskId) {
    state = state.where((task) => task.id != taskId).toList();
  }

  List<Task> toggleTaskCompletion(String taskId, String projectId) {
    state = sortTaskOptimally(
      state.map((task) {
        if (task.id == taskId && task.projectId == projectId) {
          return Task(
            id: task.id,
            title: task.title,
            note: task.note,
            startDate: task.startDate,
            startTime: task.startTime,
            endTime: task.endTime,
            isChecked: !task.isChecked,
            priority: task.priority,
            projectId: task.projectId,
          );
        }
        return task;
      }).toList(),
    );

    return getTasksByProjectId(projectId);
  }

  List<Task> sortTaskOptimally(List<Task> tasks) {
    List<Task> sortedList = List.from(tasks);
    const priorityEnum = TaskPriority.values;
    sortedList.sort((a, b) {
      // First, compare by startDate
      int dateCompare = a.startDate.compareTo(b.startDate);
      if (dateCompare != 0) return dateCompare;

      // If dates are equal, compare by startTime
      int timeCompare = a.startTime.compareTo(b.startTime);
      if (timeCompare != 0) return timeCompare;

      // If time are equal, compare by priority
      int aPriority = priorityEnum
          .where((p) => p.label == a.priority)
          .first
          .value;
      int bPriority = priorityEnum
          .where((p) => p.label == b.priority)
          .first
          .value;

      return bPriority.compareTo(aPriority);
    });

    return sortedList;
  }
}

final taskProvider = NotifierProvider<TaskNotifier, List<Task>>(
  () => TaskNotifier(),
);

List<Task> _dummyTasks = [
  Task(
    id: 'task_001',
    title: 'Redesign Login Screen',
    note:
        'Update UI elements and improve UX jkdfjhagijahijdfhaij jdsfjhkjfdahkjhfdkjhafhajhdj  fhdbfjdajjdfhlajhfjhl hjdajldfgjl',
    startDate: DateTime(2024, 01, 15),
    startTime: '09:00 AM',
    endTime: '11:00 AM',
    isChecked: false,
    priority: 'High',
    projectId: 'proj_001',
  ),
  Task(
    id: 'task_002',
    title: 'Migrate Homepage',
    note: 'Ensure SEO settings are preserved',
    startDate: DateTime(2024, 01, 20),
    startTime: '10:00 AM',
    endTime: '12:00 PM',
    isChecked: true,
    priority: 'Medium',
    projectId: 'proj_002',
  ),
  Task(
    id: 'task_003',
    title: 'Chatbot Intent Setup',
    note: 'Define intents for common customer queries',
    startDate: DateTime(2024, 02, 10),
    startTime: '01:00 PM',
    endTime: '03:00 PM',
    isChecked: false,
    priority: 'High',
    projectId: 'proj_003',
  ),
  Task(
    id: 'task_004',
    title: 'Dashboard Data Integration',
    note: 'Connect marketing API to dashboard widgets',
    startDate: DateTime(2024, 03, 05),
    startTime: '09:30 AM',
    endTime: '12:00 PM',
    isChecked: false,
    priority: 'Medium',
    projectId: 'proj_004',
  ),
  Task(
    id: 'task_005',
    title: 'Inventory Item Search',
    note: 'Implement search and filter functionality',
    startDate: DateTime(2024, 03, 15),
    startTime: '11:00 AM',
    endTime: '01:00 PM',
    isChecked: false,
    priority: 'Low',
    projectId: 'proj_005',
  ),
  Task(
    id: 'task_006',
    title: 'API Endpoint Caching',
    note: 'Reduce server load by caching frequent requests',
    startDate: DateTime(2023, 02, 25),
    startTime: '02:00 PM',
    endTime: '04:00 PM',
    isChecked: true,
    priority: 'High',
    projectId: 'proj_006',
  ),
  Task(
    id: 'task_007',
    title: 'Redesign Profile Screen',
    note: 'Align with new design system',
    startDate: DateTime(2022, 01, 18),
    startTime: '10:00 AM',
    endTime: '12:00 PM',
    isChecked: false,
    priority: 'Medium',
    projectId: 'proj_001',
  ),
  Task(
    id: 'task_0011',
    title: 'Cool',
    note: 'Align with new design system',
    startDate: DateTime(2022, 01, 18),
    startTime: '11:00 AM',
    endTime: '12:00 PM',
    isChecked: false,
    priority: 'High',
    projectId: 'proj_001',
  ),
  Task(
    id: 'task_008',
    title: 'Migrate Contact Page',
    note: 'Update links and forms',
    startDate: DateTime(2024, 01, 22),
    startTime: '01:00 PM',
    endTime: '02:30 PM',
    isChecked: false,
    priority: 'Low',
    projectId: 'proj_002',
  ),
  Task(
    id: 'task_009',
    title: 'Chatbot Testing',
    note: 'Test different user scenarios',
    startDate: DateTime(2024, 02, 12),
    startTime: '03:00 PM',
    endTime: '05:00 PM',
    isChecked: false,
    priority: 'Medium',
    projectId: 'proj_003',
  ),
  Task(
    id: 'task_010',
    title: 'Marketing Widget Optimization',
    note: 'Optimize data rendering on dashboard',
    startDate: DateTime(2024, 03, 06),
    startTime: '01:00 PM',
    endTime: '03:00 PM',
    isChecked: false,
    priority: 'High',
    projectId: 'proj_004',
  ),
];
