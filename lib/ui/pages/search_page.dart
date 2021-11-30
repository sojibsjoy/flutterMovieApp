import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/state_management/controllers/movie_controller.dart';
// import 'package:movie_app/state_management/services/api_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final MovieController movieController = Get.put(MovieController());
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
    return Column(
      children: [
        Expanded(
          child: Obx(
            () {
              if (movieController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const Text("Movie Name");
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
