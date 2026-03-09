import 'package:flutter/material.dart';
import 'watchlist_screen.dart';
import 'markets_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _index = 0;

  final pages = [
    const _DashboardPage(),
    WatchlistScreen(),
    const MarketsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: pages[_index],
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i){
          setState(() {
            _index = i;
          });
        },
        destinations: const [

          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            label: "Tomorrow",
          ),

          NavigationDestination(
            icon: Icon(Icons.show_chart),
            label: "Watchlist",
          ),

          NavigationDestination(
            icon: Icon(Icons.public),
            label: "Markets",
          ),

          NavigationDestination(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

class _DashboardPage extends StatelessWidget {
  const _DashboardPage();

  @override
  Widget build(BuildContext context) {

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [

        const Text(
          "SimpSmarTrade",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: const [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Trades"),
                    Text("0 / 4"),
                  ],
                ),

                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("PnL"),
                    Text("₹0"),
                  ],
                ),

                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Mode"),
                    Text("NORMAL"),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: const [

                Text(
                  "Tomorrow Plan",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),

                Text("Nifty S: 25400"),

                Text("Nifty R: 25600"),

              ],
            ),
          ),
        ),
      ],
    );
  }
}