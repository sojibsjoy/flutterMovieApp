import 'package:flutter/material.dart';
// import 'package:movie_app/state_management/services/api_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // @override
  // void initState() {
  //   super.initState();
  //   APIService _apiService = APIService();
  //   Future future;
  //   future = _apiService.get(
  //     endpoint: '/idlookup',
  //     query: {'country': 'uk'},
  //   );
  //   print(future);
  // }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Search",
      ),
    );
  }
}
