import 'package:get/get.dart';

import 'controller.dart';

class SearchCarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchCarController>(() => SearchCarController());
  }
}
