import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/state_management/constants/api_constants.dart';

class MovieService {
  static var client = http.Client();

  static Future getMovies() async {
    var response = await client.post(
      Uri.parse(APIConstants.apiLink),
      headers: APIConstants.headers,
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;

      var data = json.decode(jsonString);
      print(data);
      return data;
    } else {
      print(response.statusCode);
    }
  }
}
