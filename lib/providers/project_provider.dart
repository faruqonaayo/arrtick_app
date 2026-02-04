import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:arrtick_app/models/project.dart';

class ProjectNotifier extends Notifier<List<Project>> {
  @override
  List<Project> build() {
    return _dummyProjects;
  }

  void addProject(Project project) {
    state = [...state, project];
  }

  void updateProject(Project updatedProject) {
    state = state
        .map(
          (project) =>
              project.id == updatedProject.id ? updatedProject : project,
        )
        .toList();
  }

  void deleteProject(String projectId) {
    state = state.where((project) => project.id != projectId).toList();
  }

  Project? getProjectById(String projectId) {
    try {
      return state.firstWhere((project) => project.id == projectId);
    } catch (e) {
      return null;
    }
  }

  void toggleFavoriteStatus(String projectId) {
    state = state.map((project) {
      if (project.id == projectId) {
        project.isFavorite = !project.isFavorite;
      }
      return project;
    }).toList();
  }
}

final projectProvider = NotifierProvider<ProjectNotifier, List<Project>>(
  () => ProjectNotifier(),
);

final List<Project> _dummyProjects = [
  Project(
    id: "proj_001",
    name: "Mobile App Redesign",
    description: "A complete UI overhaul for the existing mobile application.",
    startDate: DateTime(2024, 01, 10),
    estimatedEndDate: DateTime(2024, 03, 01),
    endDate: null,
    isCompleted: false,
    isFavorite: true,
  ),
  Project(
    id: "proj_002",
    name: "Website Migration",
    description:
        "Migrating the old website to a modern framework with SEO improvements.",
    startDate: DateTime(2023, 11, 05),
    estimatedEndDate: DateTime(2024, 02, 15),
    endDate: DateTime(2025, 02, 12),
    isCompleted: true,
    isFavorite: false,
  ),
  Project(
    id: "proj_003",
    name: "AI Chatbot Integration",
    description:
        "Integrate an intelligent chatbot into the customer support system.",
    startDate: DateTime(2024, 02, 01),
    estimatedEndDate: DateTime(2024, 04, 20),
    endDate: null,
    isCompleted: false,
    isFavorite: false,
  ),
  Project(
    id: "proj_004",
    name: "Marketing Dashboard",
    description: "A dashboard to visualize marketing analytics in real-time.",
    startDate: DateTime(2023, 09, 20),
    estimatedEndDate: DateTime(2025, 12, 15),
    endDate: DateTime(2023, 12, 10),
    isCompleted: true,
    isFavorite: true,
  ),
  Project(
    id: "proj_005",
    name: "Inventory Management System",
    description: "Developing a cross-platform inventory tracking solution.",
    startDate: DateTime(2024, 03, 01),
    estimatedEndDate: DateTime(2025, 06, 01),
    endDate: null,
    isCompleted: false,
    isFavorite: false,
  ),
  Project(
    id: "proj_006",
    name: "API Optimization",
    description: "Improve API response time and reduce server load.",
    startDate: DateTime(2024, 01, 20),
    estimatedEndDate: DateTime(2025, 02, 28),
    endDate: null,
    isCompleted: false,
    isFavorite: true,
  ),
];
