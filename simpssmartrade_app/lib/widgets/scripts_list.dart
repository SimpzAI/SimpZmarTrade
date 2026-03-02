import 'package:flutter/material.dart';

import '../services/market_api.dart';

class ScriptsList extends StatelessWidget {
  const ScriptsList({super.key, this.showHeader = false});

  final bool showHeader;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TradeScript>>(
      future: MarketApi.instance.fetchScripts(),
      builder: (context, snap) {
        final scripts = snap.data ?? const <TradeScript>[];

        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snap.hasError) {
          return Center(
            child: Text('Could not load scripts.\n${snap.error}', textAlign: TextAlign.center),
          );
        }

        if (scripts.isEmpty) {
          return const Center(child: Text('No scripts. Set backend URL in Settings.'));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showHeader) ...[
              Text('Top ${scripts.length} scripts', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
            ],
            Expanded(
              child: ListView.separated(
                itemCount: scripts.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, i) => _ScriptCard(script: scripts[i]),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ScriptCard extends StatelessWidget {
  const _ScriptCard({required this.script});

  final TradeScript script;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    Color? badgeColor;
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
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(script.symbol, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                const SizedBox(width: 8),
                if (script.exchange != null) _Pill(text: script.exchange!),
                const Spacer(),
                if (script.newsFlag != null) _Pill(text: script.newsFlag!, color: badgeColor),
              ],
            ),
            const SizedBox(height: 8),
            if (script.oneLine != null) Text(script.oneLine!, maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (script.entry != null) _Pill(text: 'Entry: ${script.entry}'),
                if (script.sl != null) _Pill(text: 'SL: ${script.sl}'),
                if (script.t1 != null) _Pill(text: 'T1: ${script.t1}'),
                if (script.t2 != null) _Pill(text: 'T2: ${script.t2}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final bg = color?.withValues(alpha: 0.15) ?? Theme.of(context).colorScheme.surfaceContainerHighest;
    final fg = color ?? Theme.of(context).colorScheme.onSurface;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: bg,
        border: Border.all(color: (color ?? Theme.of(context).colorScheme.outline).withValues(alpha: 0.25)),
      ),
      child: Text(text, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: fg)),
    );
  }
}
