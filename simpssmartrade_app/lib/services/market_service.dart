import 'dart:convert';
import 'package:http/http.dart' as http;

class MarketService {

  Future<double?> getPrice(String symbol) async {

    try {

      final url = Uri.parse(
          "https://query1.finance.yahoo.com/v7/finance/quote?symbols=$symbol.NS");

      final response = await http.get(
        url,
        headers: {
          "User-Agent": "Mozilla/5.0",
          "Accept": "application/json"
        },
      );

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        final result = data["quoteResponse"]["result"];

        if (result.isNotEmpty) {
          return (result[0]["regularMarketPrice"] as num).toDouble();
        }
      }

      return null;

    } catch (e) {
      return null;
    }
  }
}