import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const SimpSmarTrade());
}

class SimpSmarTrade extends StatelessWidget {
  const SimpSmarTrade({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SimpSmarTrade",
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}