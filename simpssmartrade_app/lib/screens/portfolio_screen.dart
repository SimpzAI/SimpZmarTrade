import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [

          GlassCard(
            child: Column(
              children: const [
                Text("Total Value"),
                SizedBox(height: 10),
                Text("₹ 4,25,000", style: TextStyle(fontSize: 22)),
              ],
            ),
          ),

          const SizedBox(height: 20),

          const GlassCard(
            child: ListTile(
              title: Text("RELIANCE"),
              subtitle: Text("Qty 10"),
              trailing: Text("₹ 29000"),
            ),
          ),
        ],
      ),
    );
  }
}