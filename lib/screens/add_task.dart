import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:arrtick_app/models/project.dart';
import 'package:arrtick_app/models/task.dart';
import 'package:arrtick_app/models/task_priority.dart';
import 'package:arrtick_app/providers/project_provider.dart';
import 'package:arrtick_app/util.dart';

class AddTask extends ConsumerStatefulWidget {
  const AddTask({super.key});

  @override
  ConsumerState<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<AddTask> {
  final _formKey = GlobalKey<FormState>();
  var _enteredTitle = '';
  var _enteredNote = '';
  var _priority = TaskPriority.medium.label;
  var _selectedDate = DateTime.now();
  var _selectedStartTime = TimeOfDay.now();
  var _selectedEndTime = TimeOfDay.now();
  late List<Project> _allProjects;
  late Project? _selectedProject;

  @override
  void initState() {
    super.initState();
    _allProjects = ref.read(projectProvider);
    _selectedProject = _allProjects.isNotEmpty
        ? _allProjects.first
        : null; // Default to the first project if available
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            'Create a new tasks for your projects',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
              wordSpacing: 2.0,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 40),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                // Title
                TextFormField(
                  initialValue: _enteredTitle,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredTitle = newValue!.trim();
                  },
                ),
                // Note
                TextFormField(
                  initialValue: _enteredNote,
                  decoration: const InputDecoration(labelText: 'Note'),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a note';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredNote = newValue!.trim();
                  },
                ),
                // Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      "Date: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Text(formatDate(_selectedDate)),
                    IconButton(
                      onPressed: () async {
                        var today = DateTime.now();
                        final response = await presentDatePicker(
                          context,
                          today,
                          DateTime(2100),
                        );
                        if (response != null) {
                          setState(() {
                            _selectedDate = response;
                          });
                        }
                      },
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),

                Row(
                  spacing: 16,
                  children: [
                    // Time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 8,
                      children: [
                        Text(
                          "Start: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        Text(_selectedStartTime.format(context)),
                        IconButton(
                          onPressed: () async {
                            final response = await _presentTimePicker(
                              _selectedStartTime,
                            );
                            if (response != null) {
                              setState(() {
                                _selectedStartTime = response;
                                _selectedEndTime = response;
                              });
                            }
                          },
                          icon: Icon(Icons.access_time),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 8,
                      children: [
                        Text(
                          "End: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        Text(_selectedEndTime.format(context)),
                        IconButton(
                          onPressed: () async {
                            final response = await _presentTimePicker(
                              _selectedEndTime,
                            );
                            if (response != null &&
                                response.isAfter(_selectedStartTime)) {
                              setState(() {
                                _selectedEndTime = response;
                              });
                            }
                          },
                          icon: Icon(Icons.access_time),
                        ),
                      ],
                    ),
                  ],
                ),
                // Priority
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Priority'),
                  initialValue: _priority,
                  items: TaskPriority.values.map((priority) {
                    return DropdownMenuItem<String>(
                      value: priority.label,
                      child: Text(priority.label),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _priority = val!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a priority';
                    }
                    return null;
                  },
                ),

                // Project Selection
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Project'),
                  initialValue: _selectedProject?.id,
                  items: _allProjects.map((project) {
                    return DropdownMenuItem<String>(
                      value: project.id,
                      child: Text(project.name),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedProject = _allProjects.firstWhere(
                        (project) => project.id == val,
                      );
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a project';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Save Task'),
          ),
        ],
      ),
    );
  }

  Future<TimeOfDay?> _presentTimePicker(TimeOfDay initialTime) async {
    final response = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    return response;
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    // create task object and save to database or state management
    final newTask = Task(
      id: generateId(),
      title: _enteredTitle,
      note: _enteredNote,
      startDate: _selectedDate,
      startTime: _selectedStartTime.format(context),
      endTime: _selectedEndTime.format(context),
      priority: _priority,
      projectId: _selectedProject!.id,
    );

    print(newTask.toJson());
  }
}
