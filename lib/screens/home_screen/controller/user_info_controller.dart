import 'package:get/get.dart';

class UserInfoController extends GetxController {
  final RxString userName = 'John Doe'.obs;
  final RxString deliveryTime = '30'.obs;
  final RxString address = 'Ward 10, HCMC, Morena'.obs;

  void updateDeliveryTime(String time) {
    deliveryTime.value = time;
  }

  void updateAddress(String newAddress) {
    address.value = newAddress;
  }
}