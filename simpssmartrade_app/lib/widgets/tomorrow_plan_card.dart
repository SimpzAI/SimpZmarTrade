import 'package:flutter/material.dart';

class TomorrowPlanCard extends StatelessWidget {
  const TomorrowPlanCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                const Text(
                  "Tomorrow Plan",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Chip(label: Text("BASE")),

              ],
            ),

            const SizedBox(height: 12),

            const Text(
              "Demo mode (no backend set). Add backend later for automated market plan."
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              children: const [

                Chip(label: Text("Nifty S: 25400")),
                Chip(label: Text("Nifty R: 25600")),
                Chip(label: Text("Track US Futures")),

              ],
            ),

          ],
        ),
      ),
    );
  }
}