import 'package:flutter/material.dart';

import '../models/trader_profile.dart';
import '../models/day_session.dart';
import '../models/trade.dart';

import '../widgets/tomorrow_plan_card.dart';
import '../widgets/scripts_list.dart';
import '../widgets/discipline_strip.dart';

import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late TraderProfile traderProfile;
  late DaySession daySession;

  int _index = 0;

  @override
  void initState() {
    super.initState();

    traderProfile = TraderProfile(
      capital: 150000,
      riskLow: 2000,
      riskNormal: 3000,
      riskHigh: 4000,
      marketState: MarketState.normal,
      maxTrades: 4,
    );

    daySession = DaySession();
  }

  @override
  Widget build(BuildContext context) {

    final pages = <Widget>[
      const _DashboardPage(),
      const _ScriptsPage(),
      const SettingsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('SimpSmarTrade'),
      ),
      body: pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) {
          setState(() {
            _index = i;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Tomorrow',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Scripts',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class _DashboardPage extends StatelessWidget {
  const _DashboardPage();

  void _showTradeDialog(BuildContext context) {

    final scriptController = TextEditingController();
    final entryController = TextEditingController();
    final slController = TextEditingController();
    final exitController = TextEditingController();
    final qtyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(
          title: const Text("Log Trade"),

          content: SingleChildScrollView(
            child: Column(
              children: [

                TextField(
                  controller: scriptController,
                  decoration: const InputDecoration(labelText: "Script"),
                ),

                TextField(
                  controller: entryController,
                  decoration: const InputDecoration(labelText: "Entry Price"),
                  keyboardType: TextInputType.number,
                ),

                TextField(
                  controller: slController,
                  decoration: const InputDecoration(labelText: "Stoploss"),
                  keyboardType: TextInputType.number,
                ),

                TextField(
                  controller: exitController,
                  decoration: const InputDecoration(labelText: "Exit Price"),
                  keyboardType: TextInputType.number,
                ),

                TextField(
                  controller: qtyController,
                  decoration: const InputDecoration(labelText: "Quantity"),
                  keyboardType: TextInputType.number,
                ),

              ],
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {

                print("Trade Saved");

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),

          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          children: [

            DisciplineStrip(
              tradesTaken: 0,
              maxTrades: 4,
              pnl: 0,
              mode: "NORMAL",
            ),

            const SizedBox(height: 12),

            const TomorrowPlanCard(),

            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: () {
                _showTradeDialog(context);
              },
              icon: const Icon(Icons.add),
              label: const Text("Log Trade"),
            ),

            const SizedBox(height: 12),

            const Expanded(child: ScriptsList()),

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