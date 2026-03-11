import 'package:flutter/material.dart';
import 'glass_card.dart';

class CommoditiesWidget extends StatelessWidget {

  const CommoditiesWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [

          Text("Commodities"),

          SizedBox(height: 10),

          Text("Gold  ₹ --"),
          Text("Silver ₹ --"),
          Text("Crude ₹ --"),
          Text("Copper ₹ --"),
        ],
      ),
    );
  }
}