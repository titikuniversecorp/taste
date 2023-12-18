import 'package:get/get.dart';
import 'package:taste/models/restaurant_model.dart';
import 'package:taste/services/api/mock_data_generator.dart';
import 'package:taste/services/repositories/restaurant_repo.dart';

import '../services/repositories/user_addresses_repo.dart';

class RestaurantController extends GetxController {
  RestaurantController({required this.restaurantRepo});

  final RestaurantRepo restaurantRepo;

  List<RestaurantModel> _restaurantsList = [];
  List<RestaurantModel> get restaurantsList => _restaurantsList;

  RestaurantModel get currentRestaurant {
    int? lastSelectedRestorauntAddressId = Get.find<UserAddressesRepo>().lastSelectedRestorauntAddressId;
    var currentRestaurant = _restaurantsList.firstWhereOrNull((element) => element.address.id == lastSelectedRestorauntAddressId);
    return currentRestaurant ?? _restaurantsList.first;
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<List<RestaurantModel>> getRestaurans() async {
    _restaurantsList = [];
    final mockData = await MockDataGenerator.getRestaurantMockData();
    for (var element in mockData) {
      Response response = Response(statusCode: 200, body: element.toJson());//await restaurantRepo.getRestaurants();
      if (response.statusCode == 200) {
        _restaurantsList.add(RestaurantModel.fromJson(response.body));
        _isLoading = false;
        update();
      }
      else {
        // todo: handle error
      }
    }
    return _restaurantsList;
  }
}