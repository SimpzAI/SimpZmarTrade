import 'package:flutter/material.dart';
import '../services/market_data_service.dart';

class TradeScript {
  final String symbol;
  final String exchange;
  final String setup;
  final double entry;
  final double sl;
  final double t1;
  final double t2;
  final String newsFlag;

  TradeScript({
    required this.symbol,
    required this.exchange,
    required this.setup,
    required this.entry,
    required this.sl,
    required this.t1,
    required this.t2,
    required this.newsFlag,
  });
}

class ScriptsList extends StatelessWidget {
  final bool showHeader;

  const ScriptsList({super.key, this.showHeader = false});

  @override
  Widget build(BuildContext context) {

    final scripts = [

      TradeScript(
        symbol: "BEL",
        exchange: "NSE",
        setup: "Breakout above prev high; only long.",
        entry: 450,
        sl: 441,
        t1: 455,
        t2: 460,
        newsFlag: "OK",
      ),

      TradeScript(
        symbol: "SUNPHARMA",
        exchange: "NSE",
        setup: "Breakout > 1792 / VWAP reclaim.",
        entry: 1793,
        sl: 1770,
        t1: 1805,
        t2: 1820,
        newsFlag: "OK",
      ),

    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        if (showHeader)
          const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "Scripts",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        Expanded(
          child: ListView.builder(
            itemCount: scripts.length,
            itemBuilder: (context, index) {
              return _ScriptCard(script: scripts[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _ScriptCard extends StatelessWidget {

  const _ScriptCard({required this.script});

  final TradeScript script;

  @override
  Widget build(BuildContext context) {

    Color badgeColor = Colors.grey;

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
                  backgroundColor: badgeColor.withAlpha(40),
                ),

              ],
            ),

            const SizedBox(height: 8),

            /// SETUP
            Text(script.setup),

            const SizedBox(height: 10),

            /// LEVELS
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
            FutureBuilder<double?>(
              future: MarketDataService.getPrice(script.symbol),

              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Fetching live price...");
                }

                if (!snapshot.hasData) {
                  return const Text("Price unavailable");
                }

                final price = snapshot.data ?? 0;

                return Text(
                  "LTP: ₹$price",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                );

              },
            ),

          ],
        ),
      ),
    );
  }
}