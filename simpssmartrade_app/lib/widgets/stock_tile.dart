import 'package:flutter/material.dart';

class StockTile extends StatelessWidget {
  final String symbol;

  const StockTile({super.key, required this.symbol});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(symbol),
      trailing: const Text("₹ --"),
    );
  }
}