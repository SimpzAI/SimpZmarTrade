import 'package:flutter/material.dart';
import 'glass_card.dart';

class GainersLosersWidget extends StatelessWidget {

  const GainersLosersWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [

          Text("Top Gainers"),

          SizedBox(height: 10),

          Text("BEL +4.5%"),
          Text("TATASTEEL +3.2%"),

          SizedBox(height: 20),

          Text("Top Losers"),

          SizedBox(height: 10),

          Text("INFY -1.8%"),
          Text("HDFC -1.1%"),
        ],
      ),
    );
  }
}