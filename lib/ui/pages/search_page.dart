import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/state_management/controllers/episode_controller.dart';
import 'package:movie_app/state_management/models/episodes_model.dart' as model;
import 'package:movie_app/ui/widgets/search_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final EpisodeController episodeController = Get.put(EpisodeController());
  late List<model.EpisodeModel> allEpisodes;
  String query = "";

  @override
  void initState() {
    super.initState();
    allEpisodes = episodeController.episodeList;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          buildSearch(),
          Expanded(
            child: ListView.builder(
              itemCount: allEpisodes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 320,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            allEpisodes[index].image.medium,
                            width: 340,
                            height: 230,
                            // must use this fill
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 55,
                            vertical: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                allEpisodes[index].name,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: const [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Text(
                                    '7.8',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
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

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title',
        onChanged: searchEpisode,
      );

  Future searchEpisode(String query) async {
    final episodes = allEpisodes.where((episode) {
      final titleLower = episode.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      allEpisodes = episodes;
    });
  }
}
