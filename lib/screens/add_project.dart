import 'package:flutter/material.dart';

import 'package:arrtick_app/providers/project_provider.dart';
import 'package:arrtick_app/models/project.dart';
import 'package:arrtick_app/util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddProject extends ConsumerStatefulWidget {
  const AddProject({super.key});

  @override
  ConsumerState<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends ConsumerState<AddProject> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredDescription = '';
  var _selectedStartDate = DateTime.now();
  var _selectedEndDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Project')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            'Start getting organized by creating a new project',
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
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Project Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a project name.';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredName = newValue!;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a project description.';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredDescription = newValue!;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      "Start Date: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Text(formatDate(_selectedStartDate)),
                    IconButton(
                      onPressed: () async {
                        var today = DateTime.now();
                        final response = await _presentDatePicker(
                          today,
                          DateTime(2100),
                        );
                        if (response != null) {
                          setState(() {
                            _selectedStartDate = response;
                            _selectedEndDate = response;
                          });
                        }
                      },
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      "Estimated End Date: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Text(formatDate(_selectedEndDate)),
                    IconButton(
                      onPressed: () async {
                        var today = DateTime.now();
                        final response = await _presentDatePicker(
                          today,
                          DateTime(2100),
                        );
                        // making sure end date is after start date
                        if (response != null &&
                            response.isAfter(_selectedStartDate)) {
                          setState(() {
                            _selectedEndDate = response;
                          });
                        }
                      },
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
            child: const Text('Create Project'),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> _presentDatePicker(DateTime start, DateTime end) async {
    return await showDatePicker(
      context: context,
      firstDate: start,
      lastDate: end,
    );
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    // Here you can handle the form submission, e.g., save the project data
    final newProject = Project(
      id: generateId(),
      name: _enteredName,
      description: _enteredDescription,
      startDate: _selectedStartDate,
      estimatedEndDate: _selectedEndDate,
    );

    // Using Riverpod to add the new project
    final projectNotifier = ref.read(projectProvider.notifier);
    projectNotifier.addProject(newProject);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Project "${newProject.name}" created successfully!'),
      ),
    );
    // Navigator.of(context).pop();
  }
}
