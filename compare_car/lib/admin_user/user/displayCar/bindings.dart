import 'package:get/get.dart';

import 'controller.dart';

class DisplayCarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DisplayCarController>(() => DisplayCarController());
  }
}
