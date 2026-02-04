import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:arrtick_app/providers/project_provider.dart';
import 'package:arrtick_app/widgets/project_card.dart';

class Manage extends ConsumerWidget {
  const Manage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(projectProvider);
    return ListView(
      padding: const EdgeInsets.all(16.0),
      primary: true,
      children: [
        const Text(
          'Manage Your Projects',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ListView.separated(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final project = projects[index];
            return ProjectCard(project: project);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 8),
        ),
      ],
    );
  }
}
