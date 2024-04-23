import 'package:compare_car/user/detailCar/controller.dart';
import 'package:get/get.dart';

class DetailCarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailCarController>(() => DetailCarController());
  }
}
