import 'package:flutter/material.dart';
import '../services/market_data_service.dart';

class MarketsScreen extends StatelessWidget {

  const MarketsScreen({super.key});

  final List<Map<String, String>> markets = const [

    {"name": "NIFTY", "symbol": "NIFTY"},
    {"name": "SENSEX", "symbol": "SENSEX"},
    {"name": "BANKNIFTY", "symbol": "BANKNIFTY"},

    {"name": "GOLD", "symbol": "XAU/USD"},
    {"name": "SILVER", "symbol": "XAG/USD"},
    {"name": "CRUDE", "symbol": "BRENT"},

    {"name": "USDINR", "symbol": "USD/INR"},
  ];

  @override
  Widget build(BuildContext context) {

    return ListView.builder(

      itemCount: markets.length,

      itemBuilder: (context, index) {

        final item = markets[index];

        return ListTile(

          title: Text(item["name"]!),

          trailing: FutureBuilder<double?>(
            future: MarketDataService.getPrice(item["symbol"]!),

            builder: (context, snapshot) {

              if (!snapshot.hasData) {
                return const Text("...");
              }

              return Text(
                "${snapshot.data}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              );
            },
          ),
        );
      },
    );
  }
}