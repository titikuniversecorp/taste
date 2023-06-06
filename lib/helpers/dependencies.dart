import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../controllers/restaurant_controller.dart';
import '../services/api_client.dart';
import '../services/repositories/cart_repo.dart';
import '../services/repositories/restaurant_repo.dart';
import '../utils/app_constants.dart';

void init() {
  // api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL), fenix: true);

  // repositories
  Get.lazyPut(() => RestaurantRepo(apiClient: Get.find()), fenix: true);
  Get.lazyPut(() => CartRepo(), fenix: true);

  // controllers
  Get.lazyPut(() => RestaurantController(restaurantRepo: Get.find()), fenix: true);
  Get.lazyPut(() => CartController(cartRepo: Get.find()), fenix: true);
}
