class MarketService {

  static Map<String, dynamic> getIndices() {
    return {
      "NIFTY": {"price": 25420, "change": 0.6},
      "BANKNIFTY": {"price": 52800, "change": 0.8},
      "SENSEX": {"price": 83400, "change": 0.5},
    };
  }

  static List<Map<String, dynamic>> getWatchlist() {
    return [
      {"symbol": "RELIANCE", "price": 2945.20, "chg": 1.25},
      {"symbol": "TCS", "price": 4012.10, "chg": 0.62},
      {"symbol": "INFY", "price": 1610.80, "chg": -1.12},
      {"symbol": "BEL", "price": 282.35, "chg": 4.50},
    ];
  }

  static List<Map<String, dynamic>> getCommodities() {
    return [
      {"name": "Gold", "price": 72450},
      {"name": "Silver", "price": 89200},
      {"name": "Crude", "price": 6410},
      {"name": "Copper", "price": 820},
    ];
  }
}