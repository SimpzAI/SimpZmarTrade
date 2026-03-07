import 'package:flutter/material.dart';
import '../services/market_data_service.dart';

class _ScriptCard extends StatefulWidget {
  final TradeScript script;

  const _ScriptCard({required this.script});

  @override
  State<_ScriptCard> createState() => _ScriptCardState();
}

class _ScriptCardState extends State<_ScriptCard> {

  double? price;

  @override
  void initState() {
    super.initState();
    fetchPrice();

    /// refresh every 5 seconds
    Future.doWhile(() async {

      await Future.delayed(const Duration(seconds: 5));

      if (!mounted) return false;

      fetchPrice();

      return true;
    });
  }

  void fetchPrice() async {

    final p = await MarketDataService.getPrice(widget.script.symbol);

    if (!mounted) return;

    setState(() {
      price = p;
    });

  }

  @override
  Widget build(BuildContext context) {

    final script = widget.script;
    final cs = Theme.of(context).colorScheme;

    Color badgeColor;

    switch (script.newsFlag) {
      case 'OK':
        badgeColor = Colors.green;
        break;
      case 'CAUTION':
        badgeColor = Colors.orange;
        break;
      case 'AVOID':
        badgeColor = Colors.red;
        break;
      default:
        badgeColor = cs.outline;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(
                  children: [
                    Text(
                      script.symbol,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(width: 8),

                    Chip(label: Text(script.exchange)),
                  ],
                ),

                Chip(
                  label: Text(script.newsFlag),
                  backgroundColor: badgeColor.withOpacity(0.2),
                  labelStyle: TextStyle(color: badgeColor),
                ),

              ],
            ),

            const SizedBox(height: 8),

            Text(script.setup),

            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              children: [

                Chip(label: Text("Entry: ${script.entry}")),

                Chip(label: Text("SL: ${script.sl}")),

                Chip(label: Text("T1: ${script.t1}")),

                Chip(label: Text("T2: ${script.t2}")),

              ],
            ),

            const SizedBox(height: 12),

            /// LIVE PRICE

            Text(
              price == null
                  ? "Loading price..."
                  : "LTP ₹${price!.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

          ],
        ),
      ),
    );
  }
}