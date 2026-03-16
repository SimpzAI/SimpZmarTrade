import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const SimpSmarTrade());
}

class SimpSmarTrade extends StatelessWidget {
  const SimpSmarTrade({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SimpSmarTrade",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const DashboardScreen(),
    );
  }
}