class SearchService {

  static List<String> scripts = [
    "RELIANCE",
    "TCS",
    "INFY",
    "HDFCBANK",
    "ICICIBANK",
    "BEL",
    "SUNPHARMA",
    "HAL",
    "TATASTEEL",
    "SBIN"
  ];

  static List<String> search(String query) {

    return scripts
        .where((s) =>
            s.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}