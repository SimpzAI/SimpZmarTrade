import 'package:flutter/material.dart';

class MarketTicker extends StatelessWidget {

  const MarketTicker({super.key});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [

          Chip(label: Text("NIFTY 25420")),
          SizedBox(width: 10),
          Chip(label: Text("SENSEX 83400")),
          SizedBox(width: 10),
          Chip(label: Text("BANKNIFTY 52200")),
        ],
      ),
    );
  }
}