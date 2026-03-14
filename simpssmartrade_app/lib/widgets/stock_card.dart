import 'package:flutter/material.dart';
import '../services/market_service.dart';

class StockCard extends StatelessWidget {

  final String symbol;

  const StockCard({super.key, required this.symbol});

  @override
  Widget build(BuildContext context) {

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      child: ListTile(

        title: Text(symbol,
            style: const TextStyle(fontWeight: FontWeight.bold)),

        subtitle: const Text("NSE"),

        trailing: FutureBuilder<double?>(
          future: MarketService().getPrice(symbol),

          builder: (context, snapshot) {

            if (!snapshot.hasData) {
              return const Text("₹ --");
            }

            return Text(
              "₹ ${snapshot.data!.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
    );
  }
}