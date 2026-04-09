// lib/widgets/stock_tile.dart
import 'package:flutter/material.dart';
import '../screens/stock_detail_screen.dart';

class StockTile extends StatelessWidget {
  final String symbol;
  final double price;
  final double changePercent;

  const StockTile({
    super.key,
    required this.symbol,
    this.price = 0.0,
    this.changePercent = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final bool isUp = changePercent >= 0;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => StockDetailScreen(
              symbol: symbol,
              price: price,
              changePercent: changePercent,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                symbol,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "₹ ${price.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${isUp ? "+" : ""}${changePercent.toStringAsFixed(2)}%",
                  style: TextStyle(
                    color: isUp ? Colors.greenAccent : Colors.redAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}