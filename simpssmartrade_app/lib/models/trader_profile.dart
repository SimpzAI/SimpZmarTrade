enum MarketState { low, normal, high }

class TraderProfile {
  double capital;
  double riskLow;
  double riskNormal;
  double riskHigh;
  MarketState marketState;
  int maxTrades;

  TraderProfile({
    required this.capital,
    required this.riskLow,
    required this.riskNormal,
    required this.riskHigh,
    required this.marketState,
    required this.maxTrades,
  });

  double get activeRisk {
    switch (marketState) {
      case MarketState.low:
        return riskLow;
      case MarketState.high:
        return riskHigh;
      default:
        return riskNormal;
    }
  }
}