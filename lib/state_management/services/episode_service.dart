import 'package:http/http.dart' as http;
import 'package:movie_app/state_management/constants/api_constants.dart';
import 'package:movie_app/state_management/models/episodes_model.dart';

class EpisodeService {
  static Future<List<EpisodeModel>> getEpisodes() async {
    final uri = Uri.http(
      APIConstants.apiLink,
      '/shows/1/episodes',
    );
    var response = await http.get(
      uri,
      headers: APIConstants.headers,
    );
    print("Status code: ${response.statusCode}");
    if (response.statusCode == 200) {
      var jsonString = response.body;
      var episodList = episodesModelFromJson(jsonString);
      return episodList;
    } else {
      return episodesModelFromJson("");
    }
  }
}
