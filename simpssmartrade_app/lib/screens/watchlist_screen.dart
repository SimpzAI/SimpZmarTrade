import 'package:flutter/material.dart';
import '../services/market_data_service.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  final List<String> scripts = const [
    "RELIANCE",
    "TCS",
    "HDFCBANK",
    "ICICIBANK",
    "INFY",
    "BEL",
    "SUNPHARMA",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search script",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: scripts.length,
                itemBuilder: (context, index) {

                  final symbol = scripts[index];

                  return FutureBuilder<double?>(
                    future: MarketDataService.getLTP(symbol),
                    builder: (context, snapshot) {

                      String price = "--";

                      if (snapshot.hasData) {
                        price = snapshot.data!.toStringAsFixed(2);
                      }

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        child: ListTile(
                          title: Text(symbol),
                          subtitle: const Text("NSE"),
                          trailing: Text(
                            "₹ $price",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}