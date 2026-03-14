import 'dart:convert';
import 'package:http/http.dart' as http;

class MarketDataService {

  static const String apiKey = "d6qhqq1r01qhcrmk8uggd6qhqq1r01qhcrmk8uh0";

  Future<double?> getStockPrice(String symbol) async {

    try {

      final url = Uri.parse(
          "https://finnhub.io/api/v1/quote?symbol=NSE:$symbol&token=$apiKey");

      final response = await http.get(url);

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        if (data["c"] != null) {
          return (data["c"] as num).toDouble();
        }

      }

      return null;

    } catch (e) {
      print("Price error: $e");
      return null;
    }
  }
}