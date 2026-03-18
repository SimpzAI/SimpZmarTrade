import 'package:flutter/material.dart';

class MarketIndexCard extends StatelessWidget {
  const MarketIndexCard({super.key});

  @override
  Widget build(BuildContext context) {
    final indices = [
      {"name": "NIFTY", "value": "25420", "change": "+0.6%"},
      {"name": "BANKNIFTY", "value": "52800", "change": "+0.8%"},
      {"name": "SENSEX", "value": "83400", "change": "+0.5%"},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: indices.map((index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(index["name"]!,
                    style: const TextStyle(fontSize: 16)),
                Text(index["value"]!,
                    style: const TextStyle(fontSize: 16)),
                Text(index["change"]!,
                    style: const TextStyle(color: Colors.green)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}