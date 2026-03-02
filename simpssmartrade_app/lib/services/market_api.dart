import 'dart:convert';

import 'package:http/http.dart' as http;

import 'app_prefs.dart';

class MarketApi {
  MarketApi._();

  static final MarketApi instance = MarketApi._();

  Future<Uri?> _endpoint(String path) async {
    final base = await AppPrefs.getBackendUrl();
    if (base == null || base.trim().isEmpty) return null;
    final cleaned = base.endsWith('/') ? base.substring(0, base.length - 1) : base;
    return Uri.parse('$cleaned$path');
  }

  Future<TomorrowPlan?> fetchTomorrowPlan() async {
    final uri = await _endpoint('/api/v1/tomorrow');
    if (uri == null) return TomorrowPlan.demo();

    final res = await http.get(uri).timeout(const Duration(seconds: 15));
    if (res.statusCode != 200) throw Exception('HTTP ${res.statusCode}');

    final map = jsonDecode(res.body) as Map<String, dynamic>;
    return TomorrowPlan.fromJson(map);
  }

  Future<List<TradeScript>> fetchScripts() async {
    final uri = await _endpoint('/api/v1/scripts');
    if (uri == null) return TradeScript.demoList();

    final res = await http.get(uri).timeout(const Duration(seconds: 15));
    if (res.statusCode != 200) throw Exception('HTTP ${res.statusCode}');

    final list = jsonDecode(res.body) as List<dynamic>;
    return list.map((e) => TradeScript.fromJson(e as Map<String, dynamic>)).toList();
  }
}

class TomorrowPlan {
  static TomorrowPlan demo() {
    return TomorrowPlan(
      regime: 'base',
      summary: 'Demo mode (no backend set). Add backend URL in Settings to auto-generate tomorrow plan using NSE/BSE + news + US cues.',
      niftySupport: '25400',
      niftyResistance: '25600',
      usCue: 'Track S&P/Nasdaq close + US futures before open',
    );
  }

  TomorrowPlan({
    required this.regime,
    required this.summary,
    required this.niftySupport,
    required this.niftyResistance,
    this.usCue,
  });

  final String regime;
  final String summary;
  final String niftySupport;
  final String niftyResistance;
  final String? usCue;

  factory TomorrowPlan.fromJson(Map<String, dynamic> j) {
    return TomorrowPlan(
      regime: (j['regime'] ?? 'base').toString(),
      summary: (j['summary'] ?? '').toString(),
      niftySupport: (j['niftySupport'] ?? '').toString(),
      niftyResistance: (j['niftyResistance'] ?? '').toString(),
      usCue: j['usCue']?.toString(),
    );
  }
}

class TradeScript {
  static List<TradeScript> demoList() {
    return const [
      TradeScript(symbol: 'BEL', exchange: 'NSE', oneLine: 'Breakout above prev high; only long.', entry: 450, sl: 441, t1: 455, t2: 460, newsFlag: 'OK'),
      TradeScript(symbol: 'SUNPHARMA', exchange: 'NSE', oneLine: 'Breakout > 1792 / VWAP reclaim.', entry: 1793, sl: 1770, t1: 1805, t2: 1820, newsFlag: 'OK'),
      TradeScript(symbol: 'BHARTIARTL', exchange: 'NSE', oneLine: 'VWAP bounce / breakout.', entry: 1935, sl: 1912, t1: 1955, t2: 1975, newsFlag: 'OK'),
      TradeScript(symbol: 'ADANIPORTS', exchange: 'NSE', oneLine: 'Trend-follow candidate.', entry: 1550, sl: 1538, t1: 1565, t2: 1575, newsFlag: 'CAUTION'),
      TradeScript(symbol: 'MARUTI', exchange: 'NSE', oneLine: 'Auto sector strength.', entry: 15225, sl: 15080, t1: 15400, t2: 15550, newsFlag: 'OK'),
      TradeScript(symbol: 'ICICIBANK', exchange: 'NSE', oneLine: 'Base-day range trade.', entry: 1150, sl: 1135, t1: 1170, t2: 1185, newsFlag: 'OK'),
      TradeScript(symbol: 'SBIN', exchange: 'NSE', oneLine: 'PSU bank momentum watch.', entry: 1200, sl: 1180, t1: 1225, t2: 1240, newsFlag: 'CAUTION'),
      TradeScript(symbol: 'TCS', exchange: 'NSE', oneLine: 'US cue sensitive; watch Nasdaq.', entry: 4300, sl: 4240, t1: 4380, t2: 4450, newsFlag: 'OK'),
      TradeScript(symbol: 'INFY', exchange: 'NSE', oneLine: 'US cue sensitive; watch Nasdaq.', entry: 1900, sl: 1870, t1: 1930, t2: 1960, newsFlag: 'OK'),
      TradeScript(symbol: 'RELIANCE', exchange: 'NSE', oneLine: 'Range-to-breakout setup.', entry: 1425, sl: 1395, t1: 1450, t2: 1465, newsFlag: 'CAUTION'),
    ];
  }

  const TradeScript({
    required this.symbol,
    this.exchange,
    this.oneLine,
    this.entry,
    this.sl,
    this.t1,
    this.t2,
    this.newsFlag,
  });

  final String symbol;
  final String? exchange;
  final String? oneLine;
  final num? entry;
  final num? sl;
  final num? t1;
  final num? t2;
  final String? newsFlag;

  factory TradeScript.fromJson(Map<String, dynamic> j) {
    num? toNum(dynamic v) {
      if (v == null) return null;
      if (v is num) return v;
      return num.tryParse(v.toString());
    }

    return TradeScript(
      symbol: (j['symbol'] ?? '').toString(),
      exchange: j['exchange']?.toString(),
      oneLine: j['oneLine']?.toString(),
      entry: toNum(j['entry']),
      sl: toNum(j['sl']),
      t1: toNum(j['t1']),
      t2: toNum(j['t2']),
      newsFlag: j['newsFlag']?.toString(),
    );
  }
}
