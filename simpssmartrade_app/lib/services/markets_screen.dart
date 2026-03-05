import 'package:flutter/material.dart';
import '../services/market_data_service.dart';

class MarketsScreen extends StatefulWidget {
  const MarketsScreen({super.key});

  @override
  State<MarketsScreen> createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen> {

  Future<double?> getPrice(String symbol) {
    return MarketDataService.getPrice(symbol);
  }

  Widget marketTile(String name, String symbol) {
    return Card(
      child: ListTile(
        title: Text(name),
        trailing: FutureBuilder(
          future: getPrice(symbol),
          builder: (context, snapshot) {

            if (!snapshot.hasData) {
              return const Text("Loading...");
            }

            return Text(
              snapshot.data.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            );

          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [

          const Text(
            "Indian Markets",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          marketTile("NIFTY 50", "NIFTY.NSE"),
          marketTile("SENSEX", "SENSEX.BSE"),

          const SizedBox(height: 20),

          const Text(
            "US Markets",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          marketTile("S&P 500", "SPX"),
          marketTile("NASDAQ", "IXIC"),

          const SizedBox(height: 20),

          const Text(
            "Commodities",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          marketTile("Gold", "XAU/USD"),
          marketTile("Silver", "XAG/USD"),
          marketTile("Crude Oil", "BRENT"),
          marketTile("Copper", "COPPER"),

        ],
      ),
    );
  }
}