import 'dart:convert';
import 'package:http/http.dart' as http;

class MarketDataService {

  static Future<double?> getPrice(String symbol) async {

    try {

      final url =
          "https://query1.finance.yahoo.com/v7/finance/quote?symbols=$symbol.NS";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {

        final data = json.decode(response.body);

        final price =
            data["quoteResponse"]["result"][0]["regularMarketPrice"];

        return (price as num).toDouble();
      }

    } catch (e) {
      print("Price error: $e");
    }

    return null;
  }
}