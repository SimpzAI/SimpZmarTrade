import 'package:flutter/material.dart';
import '../screens/stock_detail_screen.dart';

class StockTile extends StatelessWidget {
  final String symbol;
  final double price;
  final double changePercent;

  const StockTile({
    super.key,
    required this.symbol,
    required this.price,
    required this.changePercent,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(symbol),
      subtitle: Text("₹ $price"),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => StockDetailScreen(symbol: symbol),
          ),
        );
      },
    );
  }
}