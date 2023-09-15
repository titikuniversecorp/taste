import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';
import '../api_client.dart';

class UserAddressesRepo extends GetxService {
  UserAddressesRepo({required this.apiClient, required this.sharedPreferences});

  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  Future<Response> getUserAddresses() async {
    return await apiClient.getData(AppConstants.USER_ADDRESSES_URI);
  }

  String? get currentUserAddress => sharedPreferences.getString('currentUserAddress');
  set currentUserAddress(String? value) {
    sharedPreferences.setString('currentUserAddress', value ?? '');
  }
}