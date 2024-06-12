import 'package:compare_car/admin_user/user/detailCar/controller.dart';
import 'package:get/get.dart';

class DetailCarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailCarController>(() => DetailCarController());
  }
}
