import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List stocks = [
    "RELIANCE",
    "TCS",
    "INFY",
    "HDFCBANK",
    "ICICIBANK",
    "BEL",
    "HAL",
    "TATASTEEL"
  ];

  List results = [];

  void search(String query){

    results = stocks
        .where((s)=> s.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: const Text("Search Script")),

      body: Column(

        children: [

          Padding(
            padding: const EdgeInsets.all(16),

            child: TextField(
              onChanged: search,
              decoration: const InputDecoration(
                  hintText: "Search NSE stock"),
            ),
          ),

          Expanded(
            child: ListView.builder(

              itemCount: results.length,

              itemBuilder: (context,index){

                return ListTile(
                  title: Text(results[index]),
                  subtitle: const Text("NSE"),
                );

              },
            ),
          )
        ],
      ),
    );
  }
}