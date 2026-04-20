import 'package:flutter/material.dart';
import '../widgets/stock_tile.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final stocks = [
      {"symbol": "RELIANCE", "price": 2945.20, "chg": 1.25},
      {"symbol": "TCS", "price": 4012.10, "chg": 0.62},
      {"symbol": "INFY", "price": 1610.80, "chg": -1.12},
      {"symbol": "BEL", "price": 282.35, "chg": 4.50},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: stocks.length,

        itemBuilder: (context, index) {

          final stock = stocks[index]; // ✅ THIS WAS MISSING

          return StockTile(
            symbol: stock["symbol"] as String,
            price: stock["price"] as double,
            changePercent: stock["chg"] as double,
          );
        },
      ),
    );
  }
}