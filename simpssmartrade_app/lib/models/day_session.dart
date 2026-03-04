import 'trade.dart';

class DaySession {
  List<Trade> trades = [];

  int get tradeCount => trades.length;

  double get totalR =>
      trades.fold(0, (sum, t) => sum + (t.rMultiple ?? 0));

  double get totalPnL =>
      trades.fold(0, (sum, t) => sum + (t.pnl ?? 0));

  int get consecutiveLosses {
    int count = 0;
    for (var t in trades.reversed) {
      if ((t.rMultiple ?? 0) < 0) {
        count++;
      } else {
        break;
      }
    }
    return count;
  }
}