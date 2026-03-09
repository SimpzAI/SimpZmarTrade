import 'package:flutter/material.dart';
import '../services/market_data_service.dart';

class WatchlistScreen extends StatefulWidget {
  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {

  final TextEditingController searchController = TextEditingController();

  final List<String> watchlist = [
    "RELIANCE",
    "TCS",
    "HDFCBANK",
    "ICICIBANK",
    "INFY",
    "BEL",
    "SUNPHARMA"
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Watchlist"),
      ),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search script",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: watchlist.length,
              itemBuilder: (context,index){

                final symbol = watchlist[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(

                    title: Text(symbol),

                    subtitle: const Text("NSE"),

                    FutureBuilder<double?>(
                      future: MarketDataService.getLTP(symbol),
                      builder: (context, snapshot) {

                        String price = "--";

                        if(snapshot.hasData){
                          price = snapshot.data!.toStringAsFixed(2);
                        }

                      return ListTile(
                        title: Text(symbol),
                        subtitle: Text("NSE"),
                        trailing: Text(
                          "₹ $price",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}