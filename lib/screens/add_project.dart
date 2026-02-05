import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:arrtick_app/providers/project_provider.dart';
import 'package:arrtick_app/models/project.dart';
import 'package:arrtick_app/util.dart';

class AddProject extends ConsumerStatefulWidget {
  final String? projectId;
  const AddProject({super.key, this.projectId});

  @override
  ConsumerState<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends ConsumerState<AddProject> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredDescription = '';
  var _selectedStartDate = DateTime.now();
  var _selectedEstEndDate = DateTime.now();
  late Project _projectToEdit;

  @override
  void initState() {
    super.initState();
    if (widget.projectId != null) {
      final projectNotifier = ref.read(projectProvider.notifier);
      final existingProject = projectNotifier.getProjectById(widget.projectId!);
      _projectToEdit = existingProject!;

      _enteredName = existingProject.name;
      _enteredDescription = existingProject.description;
      _selectedStartDate = existingProject.startDate;
      _selectedEstEndDate = existingProject.estimatedEndDate;
      _projectToEdit = existingProject;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.projectId == null ? 'Add Project' : 'Edit Project'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            widget.projectId == null
                ? 'Start getting organized by creating a new project'
                : 'Edit your project details',
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
              spacing: 16,
              children: [
                TextFormField(
                  initialValue: _enteredName,
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
                TextFormField(
                  initialValue: _enteredDescription,
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
                        final response = await presentDatePicker(
                          context,
                          today,
                          DateTime(2100),
                        );
                        if (response != null) {
                          setState(() {
                            _selectedStartDate = response;
                            _selectedEstEndDate = response;
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
                    Text(formatDate(_selectedEstEndDate)),
                    IconButton(
                      onPressed: () async {
                        var today = DateTime.now();
                        final response = await presentDatePicker(
                          context,
                          today,
                          DateTime(2100),
                        );
                        // making sure end date is after start date
                        if (response != null &&
                            response.isAfter(_selectedStartDate)) {
                          setState(() {
                            _selectedEstEndDate = response;
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
            child: Text(
              widget.projectId == null ? 'Create Project' : 'Save Changes',
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    // Here you can handle the form submission, e.g., save the project data

    // Using Riverpod to add the new project to the state
    final projectNotifier = ref.read(projectProvider.notifier);
    if (widget.projectId == null) {
      final newProject = Project(
        id: generateId(),
        name: _enteredName,
        description: _enteredDescription,
        startDate: _selectedStartDate,
        estimatedEndDate: _selectedEstEndDate,
      );
      projectNotifier.addProject(newProject);
    } else {
      // Editing existing project
      final updatedProject = Project(
        id: _projectToEdit.id,
        name: _enteredName,
        description: _enteredDescription,
        startDate: _selectedStartDate,
        estimatedEndDate: _selectedEstEndDate,
        endDate: _projectToEdit.endDate,
        isCompleted: _projectToEdit.isCompleted,
        isFavorite: _projectToEdit.isFavorite,
      );
      projectNotifier.updateProject(updatedProject);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.projectId == null
              ? 'Project "$_enteredName" created successfully!'
              : 'Project "$_enteredName" updated successfully!',
        ),
      ),
    );
    context.go("/");
  }
}
