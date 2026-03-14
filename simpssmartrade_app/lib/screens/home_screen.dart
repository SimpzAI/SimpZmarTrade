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

  int index = 0;

  final screens = const [

    WatchlistScreen(),
    MarketsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("SimpSmarTrade"),
      ),

      body: screens[index],

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: index,

        onTap: (i) {
          setState(() {
            index = i;
          });
        },

        items: const [

          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
              label: "Watchlist"),

          BottomNavigationBarItem(
              icon: Icon(Icons.public),
              label: "Markets"),

          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings"),
        ],
      ),
    );
  }
}