import 'package:compare_car/admin/addCar/index.dart';
import 'package:compare_car/admin/addImage/index.dart';
import 'package:compare_car/admin/addSpec/index.dart';
import 'package:compare_car/admin/deleteCar/index.dart';
import 'package:compare_car/admin/deleteSpec/index.dart';
import 'package:compare_car/homepage.dart';
import 'package:compare_car/user/compareCar/index.dart';
import 'package:compare_car/user/detailCar/index.dart';
import 'package:get/get.dart';

import 'names.dart';

class AppPages {
  // static const INITIAL = AppRoutes.INITIAL;
  static const APPlication = AppRoutes.Application;
  static const AddCar = AppRoutes.AddCar;
  // static const DeleteCar = AppRoutes.DeleteCar;
  // static const CompareCar = AppRoutes.Compare;
  static const AddSpec = AppRoutes.AddSpec;
  static const Homepage = AppRoutes.Homepage;

  static final List<GetPage> routes = [
    GetPage(
        name: AppRoutes.DETAIL,
        page: () => const DetailCarPage(),
        binding: DetailCarBinding()),
    GetPage(
        name: AppRoutes.AddCar,
        page: () => AddCarPage(),
        binding: AddCarBinding()),
    GetPage(
        name: AppRoutes.DeleteCar,
        page: () => DeleteCarPage(),
        binding: DeleteCarBinding()),
    GetPage(
        name: AppRoutes.Compare,
        page: () => const ComparePage(),
        binding: CompareBinding()),
    GetPage(
        name: AppRoutes.AddSpec,
        page: () => const AddSpecPage(),
        binding: AddSpecBinding()),
    GetPage(name: AppPages.Homepage, page: () => const HomePage()),
    GetPage(
        name: AppRoutes.AddImage,
        page: () => const AddImagePage(),
        binding: AddImageBindings()),
    GetPage(
        name: AppRoutes.DeleteSpec,
        page: () => const DeleteSpecPage(),
        binding: DeleteSpecBinding()),
  ];
}
