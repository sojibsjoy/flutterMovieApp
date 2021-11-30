import 'package:get/get.dart';
import 'package:movie_app/state_management/models/episodes_model.dart';

import 'package:movie_app/state_management/services/episode_service.dart';

class EpisodeController extends GetxController {
  var isLoading = true.obs;
  var episodeList = <EpisodesModel>[].obs;

  @override
  void onInit() {
    getMovieNames();
    super.onInit();
  }

  void getMovieNames() async {
    isLoading(true);
    try {
      var episodes = await EpisodeService.getEpisodes();
      print('Episodes are fatched successfully');
      episodeList.value = episodes;
    } finally {
      isLoading(false);
    }
  }
}
