import 'package:get/get.dart';
import 'package:taste/models/restaurant_model.dart';
import 'package:taste/services/api/mock_data_generator.dart';
import 'package:taste/services/repositories/restaurant_repo.dart';

class RestaurantController extends GetxController {
  RestaurantController({required this.restaurantRepo});

  final RestaurantRepo restaurantRepo;

  List<RestaurantModel> _restaurantsList = [];
  List<RestaurantModel> get restaurantsList => _restaurantsList;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<List<RestaurantModel>> getRestaurans() async {
    final mockData = await MockDataGenerator.getRestaurantMockData();
    Response response = Response(statusCode: 200, body: mockData.toJson());//await restaurantRepo.getRestaurants();
    if (response.statusCode == 200) {
      _restaurantsList = [];
      _restaurantsList.add(RestaurantModel.fromJson(response.body));
      _isLoading = false;
      update();
    }
    else {

    }
    return restaurantsList;
  }
}