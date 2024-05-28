import 'package:compare_car/user/home_page/controller.dart';
import 'package:get/get.dart';

import 'index.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApplicationController());
    Get.lazyPut(() => HomeController());
  }
}
