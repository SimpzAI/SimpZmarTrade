import 'package:flutter/material.dart';
import '../services/market_data_service.dart';

class StockTile extends StatelessWidget {

  final String symbol;

  const StockTile({super.key, required this.symbol});

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        title: Text(symbol),
        subtitle: const Text("NSE"),

        trailing: FutureBuilder<double?>(
          future: MarketDataService().getStockPrice(symbol),

          builder: (context, snapshot) {

            if (!snapshot.hasData) {
              return const Text("₹ --");
            }

            return Text(
              "₹ ${snapshot.data!.toStringAsFixed(2)}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
    );
  }
}