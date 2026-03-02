import 'package:flutter/material.dart';

import '../widgets/tomorrow_plan_card.dart';
import '../widgets/scripts_list.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const _DashboardPage(),
      const _ScriptsPage(),
      const SettingsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('SimpSmarTrade')),
      body: pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), label: 'Tomorrow'),
          NavigationDestination(icon: Icon(Icons.list_alt_outlined), label: 'Scripts'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
      ),
    );
  }
}

class _DashboardPage extends StatelessWidget {
  const _DashboardPage();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TomorrowPlanCard(),
            SizedBox(height: 12),
            Expanded(child: ScriptsList()),
          ],
        ),
      ),
    );
  }
}

class _ScriptsPage extends StatelessWidget {
  const _ScriptsPage();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: ScriptsList(showHeader: true),
      ),
    );
  }
}
