import 'package:flutter/material.dart';

class StockDetailScreen extends StatelessWidget {
  final String symbol;

  const StockDetailScreen({super.key, required this.symbol});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(symbol)),
      body: const Center(
        child: Text("Stock Details Screen"),
      ),
    );
  }
}