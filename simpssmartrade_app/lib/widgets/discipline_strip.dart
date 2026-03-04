import 'package:flutter/material.dart';

class DisciplineStrip extends StatelessWidget {
  final int tradesTaken;
  final int maxTrades;
  final double pnl;
  final String mode;

  const DisciplineStrip({
    super.key,
    required this.tradesTaken,
    required this.maxTrades,
    required this.pnl,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {

    Color pnlColor = pnl >= 0 ? Colors.green : Colors.red;

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Trades",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                "$tradesTaken / $maxTrades",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "PnL",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                "₹${pnl.toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: pnlColor,
                ),
              ),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "Mode",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                mode,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}