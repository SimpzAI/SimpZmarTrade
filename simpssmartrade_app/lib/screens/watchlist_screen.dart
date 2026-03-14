import 'package:flutter/material.dart';
import '../widgets/stock_card.dart';

class WatchlistScreen extends StatelessWidget {

  const WatchlistScreen({super.key});

  final List<String> stocks = const [

    "RELIANCE",
    "TCS",
    "HDFCBANK",
    "ICICIBANK",
    "INFY",
    "BEL",
    "SUNPHARMA"

  ];

  @override
  Widget build(BuildContext context) {

    return ListView.builder(

      itemCount: stocks.length,

      itemBuilder: (context, index) {

        return StockCard(symbol: stocks[index]);
      },
    );
  }
}