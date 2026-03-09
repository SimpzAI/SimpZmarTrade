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

                    trailing: FutureBuilder<double?>(
                      future: MarketDataService.getPrice(symbol),

                      builder: (context,snapshot){

                        if(!snapshot.hasData){
                          return const Text("...");
                        }

                        return Text(
                          "₹${snapshot.data}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
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