import 'package:flutter/material.dart';
import '../widgets/gainers_losers.dart';
import '../widgets/commodities_widget.dart';
import '../widgets/market_ticker.dart';

class MarketsScreen extends StatelessWidget {
  const MarketsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [

        MarketTicker(),

        SizedBox(height: 20),

        CommoditiesWidget(),

        SizedBox(height: 20),

        GainersLosersWidget(),
      ],
    );
  }
}