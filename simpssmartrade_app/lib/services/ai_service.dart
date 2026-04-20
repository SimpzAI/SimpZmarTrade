class AIService {

  static List<Map<String, String>> getTradeIdeas() {
    return [
      {"symbol": "BEL", "signal": "BUY"},
      {"symbol": "HAL", "signal": "BREAKOUT"},
      {"symbol": "TATASTEEL", "signal": "SWING"},
      {"symbol": "INFY", "signal": "AVOID"},
    ];
  }
}