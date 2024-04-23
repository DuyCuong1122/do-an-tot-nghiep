import 'package:compare_car/user/detailCar/state.dart';
import 'package:get/get.dart';

class DetailCarController extends GetxController {
  final DetailCarState state = DetailCarState();
  DetailCarController();

  @override
  void onInit() {
    super.onInit();
    var data = Get.arguments;
    state.nameCar.value = data.nameCar ?? "";
    state.thumbnail.value = data.thumbnail ?? "Error";
    state.description.value = data.description ?? "Error";
    state.price.value = data.price ?? 0.0;
    state.release.value = data.release ?? "Error";
    state.stateCar.value = data.stateCar ?? "Error";
    state.showroom.value = data.showroom ?? "Empty";

    print(data.printAll());
  }
}
