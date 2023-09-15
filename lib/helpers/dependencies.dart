import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/cart_controller.dart';
import '../controllers/restaurant_controller.dart';
import '../controllers/user_addresses_comtroller.dart';
import '../services/api_client.dart';
import '../services/repositories/cart_repo.dart';
import '../services/repositories/restaurant_repo.dart';
import '../services/repositories/user_addresses_repo.dart';
import '../utils/app_constants.dart';

void init({required SharedPreferences sharedPreferences}) {
  // api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL), fenix: true);

  // repositories
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => RestaurantRepo(apiClient: Get.find()), fenix: true);
  Get.lazyPut(() => CartRepo(), fenix: true);
  Get.lazyPut(() => UserAddressesRepo(apiClient: Get.find(), sharedPreferences: Get.find()), fenix: true);

  // controllers
  Get.lazyPut(() => RestaurantController(restaurantRepo: Get.find()), fenix: true);
  Get.lazyPut(() => CartController(cartRepo: Get.find()), fenix: true);
  Get.lazyPut(() => UserAddressesController(userAddressesRepo: Get.find()), fenix: true);
}
