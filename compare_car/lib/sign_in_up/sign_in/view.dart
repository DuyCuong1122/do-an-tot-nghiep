import 'package:compare_car/common/values/colors.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:compare_car/common/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../common/values/shadows.dart';
import 'index.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget _buildLogo() {
      return Container(
        width: 110,
        margin: const EdgeInsets.only(top: 84),
        child: Column(
          children: [
            Container(
              width: 76,
              height: 76,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Stack(
                children: [
                  Positioned(
                      child: Container(
                    height: 76,
                    decoration: const BoxDecoration(
                        color: AppColors.primaryBackground,
                        boxShadow: [Shadows.primaryShadow],
                        borderRadius: BorderRadius.all(Radius.circular(35))),
                  )),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              child: const Text(
                "Let's chat",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.thirdElement, fontSize: 18, height: 1),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildThirdPartyLogin() {
      return Container(
        width: 295,
        // margin: EdgeInsets.only(bottom: 280),
        child: Column(
          children: [
            const Text("Sign in with social networks",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 16,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
              child: btnFlatButtonWidget(
                  onPressed: () => controller.handleSignInGoogle(),
                  width: 200,
                  height: 55,
                  title: "Google Login"),
            )
          ],
        ),
      );
    }

    Widget returnSignUpPage() {
      return GestureDetector(
        onTap: () => Get.offAndToNamed("/sign_up"),
        child: const Text('Don\'t have an account? Sign up'),
      );
    }

    Widget buildFormSignIn() {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: controller.passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            Center(
              child: ElevatedButton(
                child: const Text("Sign in"),
                onPressed: () => controller.handleSignInDB(),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
        body: Center(
      child: Column(
        children: [
          _buildLogo(),
          buildFormSignIn(),
          const Spacer(),
          _buildThirdPartyLogin(),
          returnSignUpPage(),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    ));
  }
}
