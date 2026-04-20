import 'package:flutter/material.dart';
import '../services/search_service.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<String> results = [];

  void search(String query) {
    results = SearchService.search(query);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: SafeArea(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                onChanged: search,
                decoration: const InputDecoration(
                  hintText: "Search stock...",
                  filled: true,
                ),
              ),
            ),

            Expanded(
              child: ListView(
                children: results
                    .map((e) => ListTile(
                          title: Text(e),
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}