import 'package:flutter/material.dart';
import '../services/ai_trade_service.dart';
import 'glass_card.dart';


class AITradeWidget extends StatelessWidget {

  const AITradeWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final ideas = AITradeService.generateIdeas();

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "AI Trade Ideas",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          ...ideas.map((idea) {

            Color color;

            if (idea.signal == "BUY") {
              color = Colors.green;
            } else if (idea.signal == "AVOID") {
              color = Colors.red;
            } else {
              color = Colors.orange;
            }

            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(idea.symbol),
              subtitle: Text(idea.reason),
              trailing: Text(
                idea.signal,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}