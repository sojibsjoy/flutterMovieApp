import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Container(
                  height: 250,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/movie_poster.jpg',
                          height: 200,
                          width: 200,
                        ),
                        const Text(
                          "Movie Name",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
