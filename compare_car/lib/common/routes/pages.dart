import 'package:compare_car/admin/addCar/index.dart';
import 'package:compare_car/admin/addImage/index.dart';
import 'package:compare_car/admin/addSpec/index.dart';
import 'package:compare_car/admin/deleteCar/index.dart';
import 'package:compare_car/admin/deleteSpec/index.dart';
import 'package:compare_car/center_page.dart';
import 'package:compare_car/user/application/index.dart';
import 'package:compare_car/user/compareCar/index.dart';
import 'package:compare_car/user/detailCar/index.dart';
import 'package:compare_car/user/displayCar/index.dart';
import 'package:get/get.dart';

import '../../sign_in_up/sign_in/index.dart';
import '../../sign_in_up/sign_up/index.dart';
import '../../user/home_page/index.dart';
import 'names.dart';

class AppPages {
  // static const INITIAL = AppRoutes.INITIAL;
  static const APPlication = AppRoutes.Application;
  static const SignIn = AppRoutes.SignIn;
  static const SignUp = AppRoutes.SignUp;
  // static const DeleteCar = AppRoutes.DeleteCar;
  // static const CompareCar = AppRoutes.Compare;
  static const Center = AppRoutes.Center;

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
    GetPage(
        name: AppRoutes.Homepage,
        page: () => const HomePage(),
        binding: HomeBinding()),
    GetPage(
        name: AppRoutes.AddImage,
        page: () => const AddImagePage(),
        binding: AddImageBindings()),
    GetPage(
        name: AppRoutes.DeleteSpec,
        page: () => const DeleteSpecPage(),
        binding: DeleteSpecBinding()),
    GetPage(
        name: AppRoutes.DISPLAYALLCAR,
        page: () => const DisplayCarPage(),
        binding: DisplayCarBinding()),
    GetPage(name: AppRoutes.Center, page: () => const CenterPage()),
    GetPage(
        name: AppPages.APPlication,
        page: () => const ApplicationPage(),
        binding: ApplicationBinding()),
    GetPage(
        name: AppPages.SignIn,
        page: () => const SignInPage(),
        binding: SignInBinding()),
    GetPage(
        name: AppRoutes.SignUp,
        page: () => SignUpPage(),
        binding: SignUpBinding())
  ];
}
