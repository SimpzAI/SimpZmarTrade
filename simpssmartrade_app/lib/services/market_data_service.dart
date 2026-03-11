import 'dart:convert';
import 'package:http/http.dart' as http;

class MarketDataService {

  static const apiKey = "YOUR_TWELVEDATA_API_KEY";

  static Future<double?> getPrice(String symbol) async {

    final url = Uri.parse(
        "https://api.twelvedata.com/price?symbol=$symbol&apikey=$apiKey");

    final response = await http.get(url);

    if (response.statusCode == 200) {

      final data = json.decode(response.body);

      if (data["price"] != null) {
        return double.parse(data["price"]);
      }
    }

    return null;
  }
}