import 'package:flutter/material.dart';

class AISuggestionCard extends StatelessWidget {
  const AISuggestionCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: const [

            Text("AI Trade Ideas",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),

            SizedBox(height:10),

            Text("BEL  — BUY"),
            Text("HAL  — BREAKOUT"),
            Text("TATASTEEL — SWING"),
            Text("INFY — AVOID")

          ],
        ),
      ),
    );
  }
}