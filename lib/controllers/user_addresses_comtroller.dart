import 'package:get/get.dart';
import 'package:taste/controllers/restaurant_controller.dart';
import 'package:taste/models/user_address_model.dart';
import 'package:taste/services/api/mock_data_generator.dart';
import 'package:taste/services/repositories/user_addresses_repo.dart';

enum VisitingType {
  /// В заведении
  inPlace,

  /// С собой (самовывоз)
  pickup,

  /// Доставка
  delivery,
}

extension VisitingTypeExtension on VisitingType {
  String get asString {
    if (this == VisitingType.pickup) {
      return 'С собой';
    } else if (this == VisitingType.delivery) {
      return 'Доставка';
    } else if (this == VisitingType.inPlace) {
      return 'В ресторане';
    }
    return 'null';
  }
}

class UserAddressesController extends GetxController {
  UserAddressesController({required this.userAddressesRepo});

  final UserAddressesRepo userAddressesRepo;

  List<AddressModel> _userAdressesList = [];
  List<AddressModel> get userAdressesList => _userAdressesList;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  // ignore: prefer_final_fields
  VisitingType _visitingType = VisitingType.pickup;
  VisitingType get visitingType => _visitingType;
  set visitingType(VisitingType value) {
    _visitingType = value;
    update();
  }

  Future<List<AddressModel>> getUserAddresses() async {
    final mockData = await MockDataGenerator.getUserAdresses();
    Response response = Response(statusCode: 200, body: AddressModel.addressesToJson(mockData));//await userAddressesRepo.getUserAddresses();
    if (response.statusCode == 200) {
      _userAdressesList = [];
      _userAdressesList.addAll(AddressModel.addressesFromJson(response.body));
      _isLoading = false;
      update();
    }
    else {
      // todo: handle error
    }
    return userAdressesList;
  }

  void setCurrentUserAddress(AddressModel userAddress) {
    userAddressesRepo.currentUserAddress = userAddress.addressToJson();
    update();
  }

  AddressModel? getCurrentUserAddress() {
    if (userAddressesRepo.currentUserAddress != null) return AddressModel.addressFromJson(userAddressesRepo.currentUserAddress!);
    return null;
  }

  set currentRestorauntAddressId(int? value) {
    userAddressesRepo.lastSelectedRestorauntAddressId = value;
    update();
    Get.find<RestaurantController>().update();
  }
  int? get currentRestorauntAddressId => userAddressesRepo.lastSelectedRestorauntAddressId;
}