import 'package:flutter/material.dart';
import '../widgets/ai_suggestion_card.dart';
import 'watchlist_screen.dart';
import 'search_screen.dart';
import 'settings_screen.dart';
import 'portfolio_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int index = 0;

  final pages = [
    const DashboardHome(),
    const WatchlistScreen(),
    const SearchScreen(),
    const PortfolioScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),

      body: SafeArea(
        child: pages[index],
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1A1A2E),
        selectedItemColor: Colors.tealAccent,
        unselectedItemColor: Colors.grey,

        currentIndex: index,
        onTap: (i) => setState(() => index = i),

        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: "Home"),

          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
              label: "Watchlist"),

          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search"),

          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: "Portfolio"),

          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings"),
        ],
      ),
    );
  }
}

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {

    return ListView(
      padding: const EdgeInsets.all(16),

      children: const [

        AISuggestionCard(),

      ],
    );
  }
}