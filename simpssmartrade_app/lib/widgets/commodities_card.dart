import 'package:flutter/material.dart';

class CommoditiesCard extends StatelessWidget {
  const CommoditiesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final commodities = [
      {"name": "Gold", "price": "₹ 72450"},
      {"name": "Silver", "price": "₹ 89200"},
      {"name": "Crude", "price": "₹ 6410"},
      {"name": "Copper", "price": "₹ 820"},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Commodities",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...commodities.map((c) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(c["name"]!),
                    Text(c["price"]!),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}