class SearchService {

  static List<String> stocks = [
    "RELIANCE",
    "TCS",
    "INFY",
    "HDFCBANK",
    "ICICIBANK",
    "SBIN",
    "BEL",
    "HAL",
    "TATASTEEL",
  ];

  static List<String> search(String query) {
    return stocks
        .where((s) =>
            s.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}