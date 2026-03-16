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
      body: pages[index],

     bottomNavigationBar: BottomNavigationBar(
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
      children: [

        Text("SimpSmarTrade",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),

        SizedBox(height: 20),

        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text("Tomorrow Plan", style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text("Nifty Support : 25400"),
                Text("Nifty Resistance : 25600")
              ],
            ),
          ),
        ),

        SizedBox(height: 20),

        AISuggestionCard()

      ],
    );
  }
}