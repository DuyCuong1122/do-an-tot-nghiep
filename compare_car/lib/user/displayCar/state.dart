import 'package:compare_car/common/entities/car.dart';
import 'package:get/get.dart';

class DisplayCarState {
  RxString name = ''.obs;
  RxString image = ''.obs;
  RxList<Car> cars = <Car>[].obs;
}
