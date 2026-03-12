import 'package:flutter/material.dart';
import '../services/market_data_service.dart';
import '../widgets/glass_card.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {

  List<String> scripts = [
    "RELIANCE.NSE",
    "TCS.NSE",
    "HDFCBANK.NSE",
    "ICICIBANK.NSE",
    "INFY.NSE",
    "BEL.NSE",
    "SUNPHARMA.NSE"
  ];

  String search = "";

  @override
  Widget build(BuildContext context) {

    final filtered = scripts
        .where((e) => e.toLowerCase().contains(search.toLowerCase()))
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
            onChanged: (v) {
              setState(() {
                search = v;
              });
            },
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, i) {

                final symbol = filtered[i];

                return FutureBuilder<double?>(
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
                              fontSize: 16,
                            ),
                          );
                        },
                      )
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GlassCard(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(symbol.split(".")[0],
                                    style: const TextStyle(fontSize: 18)),
                                const Text("NSE")
                              ],
                            ),

                            Text(
                              price == null ? "₹ --" : "₹ $price",
                              style: const TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}