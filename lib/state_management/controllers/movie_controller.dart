import 'package:get/get.dart';
import 'package:movie_app/state_management/services/movie_service.dart';

class MovieController extends GetxController {
  var isLoading = true.obs;

  @override
  void onInit() {
    getMovieNames();
    super.onInit();
  }

  void getMovieNames() async {
    isLoading(true);
    try {
      var movies = await MovieService.getMovies();
      if (movies != null) {
        print('Movies are fatched successfully');
      }
    } finally {
      isLoading(false);
    }
  }
}
