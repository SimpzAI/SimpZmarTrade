import 'dart:convert';
import 'package:http/http.dart' as http;

class MarketDataService {

  static Future<double?> getPrice(String symbol) async {

    try {

      final url =
          "https://financialmodelingprep.com/api/v3/quote-short/$symbol.NS?apikey=demo";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {

        final data = json.decode(response.body);

        if (data.length > 0) {
          return (data[0]["price"] as num).toDouble();
        }
      }

    } catch (e) {
      print("API error: $e");
    }

    return null;
  }
}