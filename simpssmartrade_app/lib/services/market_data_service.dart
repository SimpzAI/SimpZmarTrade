class MarketDataService {

  static Future<double?> getPrice(String symbol) async {

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Temporary test value
    return 1234.56;

  }

}