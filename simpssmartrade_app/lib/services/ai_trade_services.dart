class TradeIdea {
  final String symbol;
  final String signal;
  final String reason;

  TradeIdea({
    required this.symbol,
    required this.signal,
    required this.reason,
  });
}

class AITradeService {

  static List<TradeIdea> generateIdeas() {

    return [
      TradeIdea(
        symbol: "BEL",
        signal: "BUY",
        reason: "Defence sector momentum",
      ),
      TradeIdea(
        symbol: "HAL",
        signal: "BREAKOUT",
        reason: "Strong buying volume",
      ),
      TradeIdea(
        symbol: "TATASTEEL",
        signal: "SWING",
        reason: "Metal sector strength",
      ),
      TradeIdea(
        symbol: "INFY",
        signal: "AVOID",
        reason: "Weak IT sentiment",
      ),
    ];

  }

}