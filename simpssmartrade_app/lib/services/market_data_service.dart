import 'dart:convert';
import 'package:http/http.dart' as http;

class MarketDataService {

  Future<double?> getStockPrice(String symbol) async {

    try {

      final url = Uri.parse(
          "https://query1.finance.yahoo.com/v7/finance/quote?symbols=$symbol.NS");

      final response = await http.get(url);

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        final result = data["quoteResponse"]["result"];

        if (result.isNotEmpty) {
          return (result[0]["regularMarketPrice"] as num).toDouble();
        }

      }

      return null;

    } catch (e) {
      print("API error: $e");
      return null;
    }
  }
}