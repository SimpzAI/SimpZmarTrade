import 'package:flutter/material.dart';

class MarketsScreen extends StatelessWidget {
  const MarketsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Markets"),
      ),

      body: const Center(
        child: Text(
          "Live Markets Coming Soon",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),

    );
  }
}