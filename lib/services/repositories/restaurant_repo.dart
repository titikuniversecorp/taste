import 'package:get/get.dart';

import '../../services/api_client.dart';
import '../../utils/app_constants.dart';

class RestaurantRepo extends GetxService {
  RestaurantRepo({required this.apiClient});

  final ApiClient apiClient;

  Future<Response> getRestaurants() async {
    return await apiClient.getData(AppConstants.RESTAURANT_URI);
  }
}