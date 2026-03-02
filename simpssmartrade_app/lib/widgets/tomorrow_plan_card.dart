import 'package:flutter/material.dart';

import '../services/market_api.dart';

class TomorrowPlanCard extends StatelessWidget {
  const TomorrowPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TomorrowPlan?>(
      future: MarketApi.instance.fetchTomorrowPlan(),
      builder: (context, snap) {
        final plan = snap.data;

        if (snap.connectionState == ConnectionState.waiting) {
          return const _CardShell(child: Center(child: LinearProgressIndicator()));
        }

        if (snap.hasError) {
          return _CardShell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tomorrow Plan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text('Backend error. Check Settings → Backend URL.\n${snap.error}', maxLines: 3, overflow: TextOverflow.ellipsis),
              ],
            ),
          );
        }

        if (plan == null) {
          return const _CardShell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tomorrow Plan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                SizedBox(height: 8),
                Text('Set backend URL in Settings to auto-generate plan.'),
              ],
            ),
          );
        }

        return _CardShell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Tomorrow Plan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  const Spacer(),
                  _Tag(text: plan.regime.toUpperCase()),
                ],
              ),
              const SizedBox(height: 10),
              Text(plan.summary, maxLines: 3, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _Tag(text: 'Nifty S: ${plan.niftySupport}'),
                  _Tag(text: 'Nifty R: ${plan.niftyResistance}'),
                  if (plan.usCue != null) _Tag(text: 'US: ${plan.usCue}'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CardShell extends StatelessWidget {
  const _CardShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(padding: const EdgeInsets.all(14), child: child),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}
