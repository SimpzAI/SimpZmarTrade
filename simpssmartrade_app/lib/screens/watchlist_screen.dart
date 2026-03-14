import 'package:flutter/material.dart';
import '../services/market_data_service.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {

  final List<String> scripts = [
    "RELIANCE",
    "TCS",
    "HDFCBANK",
    "ICICIBANK",
    "INFY",
    "BEL",
    "SUNPHARMA"
  ];

  String search = "";

  @override
  Widget build(BuildContext context) {

    final filtered = scripts
        .where((s) => s.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [

            TextField(
              decoration: const InputDecoration(
                hintText: "Search script",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (v){
                setState(() {
                  search = v;
                });
              },
            ),

            const SizedBox(height: 20),

            ...filtered.map((symbol) {

              return Card(
                margin: const EdgeInsets.only(bottom: 15),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            symbol,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text("NSE"),
                        ],
                      ),

                      FutureBuilder<double?>(
                        future: MarketDataService().getStockPrice(symbol),
                        builder: (context, snapshot) {

                          if (!snapshot.hasData) {
                            return Text("₹ --");
                          }

                          return Text(
                           "₹ ${snapshot.data!.toStringAsFixed(2)}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          );
                        },
                      )

                    ],
                  ),
                ),
              );

            }).toList()

          ],
        ),
      ),
    );
  }
}