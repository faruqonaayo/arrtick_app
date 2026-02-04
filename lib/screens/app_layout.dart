import 'package:flutter/material.dart';

import 'package:arrtick_app/theme.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int _selectedIndex = 0;

  final _pages = [
    const Center(child: Text('Home Page')),
    const Center(child: Text('Add Page')),
    const Center(child: Text('Manage Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            'assets/images/arrtick_logo.png',
            width: 20,
            height: 20,
            fit: BoxFit.cover,
          ),
        ),
        title: const Text('Arrtick'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // Handle settings action
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _buildBottomNavBarItems(),
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavBarItems() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        label: 'Home',
      ),
      BottomNavigationBarItem(icon: _buildAddButton(), label: ''),
      const BottomNavigationBarItem(
        icon: Icon(Icons.category_outlined),
        label: 'Manage',
      ),
    ];
  }

  Widget _buildAddButton() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: yellowColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Icon(
        Icons.add,
        color: Theme.of(context).colorScheme.surface,
        size: 32,
      ),
    );
  }
}
