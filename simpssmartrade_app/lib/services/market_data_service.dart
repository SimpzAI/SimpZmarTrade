import 'dart:convert';
import 'package:http/http.dart' as http;

class MarketDataService {

  static Future<double?> getPrice(String symbol) async {

    try {

      final url =
          "https://query1.finance.yahoo.com/v7/finance/quote?symbols=$symbol.NS";

      print("Fetching price for: $symbol");

      final response = await http.get(
        Uri.parse(url),
        headers: {"User-Agent": "Mozilla/5.0"},
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {

        final data = json.decode(response.body);

        if (data["quoteResponse"]["result"].length > 0) {

          final price =
              data["quoteResponse"]["result"][0]["regularMarketPrice"];

          return (price as num).toDouble();
        }
      }

    } catch (e) {
      print("Market API ERROR: $e");
    }

    return null;
  }
}