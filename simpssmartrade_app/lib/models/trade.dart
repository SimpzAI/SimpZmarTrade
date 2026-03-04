class Trade {
  String scriptName;
  double entry;
  double stopLoss;
  double riskAmount;
  double positionSize;
  double? exitPrice;
  double? rMultiple;
  double? pnl;

  Trade({
    required this.scriptName,
    required this.entry,
    required this.stopLoss,
    required this.riskAmount,
    required this.positionSize,
  });

  void closeTrade(double exit) {
    exitPrice = exit;
    double riskPerShare = (entry - stopLoss).abs();
    double profitPerShare = exit - entry;
    rMultiple = profitPerShare / riskPerShare;
    pnl = rMultiple! * riskAmount;
  }
}