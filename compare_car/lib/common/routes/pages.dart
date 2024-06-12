import 'package:get/get.dart';

import '../../admin_user/admin/addCar/index.dart';
import '../../admin_user/admin/addImage/index.dart';
import '../../admin_user/admin/addSpec/index.dart';
import '../../admin_user/admin/deleteCar/index.dart';
import '../../admin_user/admin/deleteSpec/index.dart';
import '../../admin_user/profile/index.dart';
import '../../admin_user/user/application/index.dart';
import '../../admin_user/user/compareCar/index.dart';
import '../../admin_user/user/detailCar/index.dart';
import '../../admin_user/user/displayCar/index.dart';
import '../../admin_user/user/home_page/index.dart';
import '../../center_page.dart';
import '../../sign_in_up/sign_in/index.dart';
import '../../sign_in_up/sign_up/index.dart';
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
        binding: SignUpBinding()),
    GetPage(
        name: AppRoutes.Profile,
        page: () => ProfilePage(),
        binding: ProfileBinding())
  ];
}
