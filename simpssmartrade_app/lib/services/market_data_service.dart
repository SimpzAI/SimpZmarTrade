import 'dart:convert';
import 'package:http/http.dart' as http;

class MarketDataService {

  static Future<double?> getPrice(String symbol) async {

    try {

      final url =
          "https://query1.finance.yahoo.com/v7/finance/quote?symbols=$symbol.NS";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        final result = data["quoteResponse"]["result"];

        if (result.length > 0) {
          return result[0]["regularMarketPrice"];
        }
      }

    } catch (e) {
      print("Market API error: $e");
    }

    return null;
  }
}