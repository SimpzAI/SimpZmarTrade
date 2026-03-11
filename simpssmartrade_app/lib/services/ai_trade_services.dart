import '../models/trade_idea.dart';

class AITradeService {

  static List<TradeIdea> generateIdeas() {

    List<TradeIdea> ideas = [

      TradeIdea(
        symbol: "BEL",
        signal: "BUY",
        reason: "Defence sector momentum",
      ),

      TradeIdea(
        symbol: "HAL",
        signal: "BREAKOUT",
        reason: "Strong institutional buying",
      ),

      TradeIdea(
        symbol: "TATASTEEL",
        signal: "SWING",
        reason: "Metal sector recovery",
      ),

      TradeIdea(
        symbol: "INFY",
        signal: "AVOID",
        reason: "Weak IT sentiment",
      ),
    ];

    return ideas;
  }
}