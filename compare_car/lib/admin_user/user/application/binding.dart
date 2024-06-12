import 'package:compare_car/admin_user/user/home_page/controller.dart';
import 'package:get/get.dart';

import '../post/controller.dart';
import 'index.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApplicationController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => PostController());
  }
}
