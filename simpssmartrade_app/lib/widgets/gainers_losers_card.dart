import 'package:flutter/material.dart';

class GainersLosersCard extends StatelessWidget {
  const GainersLosersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Top Gainers",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Text("BEL  +4.5%"),
          Text("TATASTEEL  +3.2%"),
          SizedBox(height: 12),
          Text("Top Losers",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("INFY  -1.8%"),
          Text("HDFC  -1.1%"),
        ],
      ),
    );
  }
}