import 'dart:convert';
import 'package:http/http.dart' as http;

class MarketDataService {

  static const String apiKey = "6d1268f577ee44ac9e3f280d45ef9a44";

  static Future<double?> getLTP(String symbol) async {

    final url = Uri.parse(
  "https://api.twelvedata.com/price?symbol=$symbol.NSE&apikey=$apiKey"
  );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data["price"] != null) {
        return double.tryParse(data["price"]);
      }
    }

    return null;
  }
}