import 'dart:convert';
import 'package:http/http.dart' as http;

class MarketDataService {

  static const apiKey = "YOUR_API_KEY";

  static Future<double?> getPrice(String symbol) async {

    final url =
        "https://api.twelvedata.com/price?symbol=$symbol:NSE&apikey=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      if (data["price"] != null) {
        return double.parse(data["price"]);
      }
    }

    return null;
  }
}