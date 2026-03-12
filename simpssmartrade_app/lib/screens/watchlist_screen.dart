import 'package:flutter/material.dart';
import '../services/market_data_service.dart';
import '../widgets/glass_card.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {

  final List<String> symbols = [
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

    final filtered = symbols
        .where((s) => s.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [

          TextField(
            decoration: const InputDecoration(
              hintText: "Search script",
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              setState(() {
                search = value;
              });
            },
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {

                final symbol = filtered[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GlassCard(
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
                          future: MarketDataService.getPrice(symbol),
                          builder: (context, snapshot) {

                            if (!snapshot.hasData) {
                              return const Text("₹ --");
                            }

                            final price = snapshot.data;

                            return Text(
                              "₹ $price",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),

                      ],
                    ),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}