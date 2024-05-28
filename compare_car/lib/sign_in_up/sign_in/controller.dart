import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:compare_car/common/store/store.dart';
import 'package:compare_car/common/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../common/entities/user.dart';
import '../../common/routes/names.dart';
import 'index.dart';

GoogleSignIn googleSignIn = GoogleSignIn(scopes: <String>['openid']);

class SignInController extends GetxController {
  final state = SignInState();
  SignInController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final db = FirebaseFirestore.instance;
  Future<void> handleSignIn() async {
    try {
      var user = await googleSignIn.signIn();
      if (user != null) {
        final gAuthentication = await user
            .authentication; // display gmail account in authentication
        final credential = GoogleAuthProvider.credential(
            idToken: gAuthentication.idToken,
            accessToken: gAuthentication.accessToken);

        await FirebaseAuth.instance.signInWithCredential(credential);

        String displayName = user.displayName ?? user.email;
        String email = user.email;
        String id = user.id;
        String photoUrl = user.photoUrl ?? "";
        UserLoginResponseEntity userProfile = UserLoginResponseEntity();
        userProfile.email = email;
        userProfile.accessToken = id;
        userProfile.displayName = displayName;
        userProfile.photoUrl = photoUrl;

        UserStore.to.saveProfile(userProfile);
        String profile = await UserStore.to.getProfile();
        log(profile);
        // var userbase = await db // nếu có thì lấy ra id
        //     .collection("users")
        //     .withConverter(
        //         fromFirestore: UserData.fromFirestore,
        //         toFirestore: (UserData userdata, options) =>
        //             userdata.toFirestore())
        //     .where("id", isEqualTo: id)
        //     .get();
        // if (userbase.docs.isEmpty) {
        //   // check rỗng, nếu không có thì thêm vào database
        //   final data = UserData(
        //       id: id,
        //       name: displayName,
        //       email: email,
        //       photourl: photoUrl,
        //       location: "",
        //       fcmtoken: "",
        //       addtime: Timestamp.now());
        //   await db
        //       .collection("users")
        //       .withConverter(
        //           fromFirestore: UserData.fromFirestore,
        //           toFirestore: (UserData userdata, options) =>
        //               userdata.toFirestore())
        //       .add(data);
        // }
        // toastInfo(msg: "Login success");
        log("success fully");
        Get.offAndToNamed(AppRoutes.Center);
      } else {
        log("Google Sign-In was canceled.");
      }
    } catch (e) {
      print("Sign-In Error: $e");
      toastInfo(msg: "Login error");
    }
  }

  @override
  void onReady() {
    super.onReady();
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     print("User is currently logged out");
    //   } else {
    //     print("User is logged in");
    //   }
    // });
  }

  // Future<void> signInWithGoogle() async {
  //   try {
  //     var googleUser = await googleSignIn.signIn();
  //     if (googleUser != null) {
  //       final GoogleSignInAuthentication googleAuth =
  //           await googleUser.authentication;
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );
  //       final User? user = (await auth.signInWithCredential(credential)).user;
  //       final String? email = user!.email;
  //       final String googleId = user.uid;
  //       String displayName = user.displayName ?? user.email;
  //       String email = user.email;
  //       String id = user.id;
  //       String photoUrl = user.photoUrl ?? "";
  //       UserLoginResponseEntity userProfile = UserLoginResponseEntity();
  //       userProfile.email = email;
  //       userProfile.accessToken = id;
  //       userProfile.displayName = displayName;
  //       userProfile.photoUrl = photoUrl;

  //       UserStore.to.saveProfile(userProfile);
  //     }

  //     final response = await http.post(
  //       Uri.parse('http://your-server-address/google-login'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, String>{
  //         'email': email!,
  //         'googleId': googleId,
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);
  //       state.token = responseData['token'];
  //     } else {
  //       print('Failed to login with Google');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
