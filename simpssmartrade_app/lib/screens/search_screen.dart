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
    return Column(
      children: [
        TextField(onChanged: search),
        Expanded(
          child: ListView(
            children: results.map((e) => ListTile(title: Text(e))).toList(),
          ),
        )
      ],
    );
  }
}