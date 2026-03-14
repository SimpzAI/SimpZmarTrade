import 'package:flutter/material.dart';
import '../widgets/ai_trade_card.dart';

class TomorrowScreen extends StatelessWidget {

  const TomorrowScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return ListView(

      padding: const EdgeInsets.all(16),

      children: const [

        Card(
          child: Padding(
            padding: EdgeInsets.all(16),

            child: Column(
              children: [

                Text(
                  "Tomorrow Plan",
                  style: TextStyle(fontSize:18),
                ),

                SizedBox(height:10),

                Text("Nifty Support: 25400"),
                Text("Nifty Resistance: 25600"),

              ],
            ),
          ),
        ),

        SizedBox(height:20),

        AITradeCard()

      ],
    );
  }
}