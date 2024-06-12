import 'dart:convert';
import 'dart:io';
import 'package:compare_car/common/config/config.dart';
import 'package:compare_car/common/entities/entities.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../common/store/user.dart';
import 'state.dart';
import 'widget/view_image.dart';

class PostController extends GetxController {
  final state = PostState();
  final textController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  // Điều chỉnh fetchAllPost để trả về List<dynamic>
  Future<List<dynamic>> fetchAllPost() async {
    try {
      final response = await http.get(Uri.parse(allPostURL));
      if (response.statusCode == 200) {
        // Trả về danh sách các bài viết
        return json.decode(response.body) as List<dynamic>;
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts: $e');
    }
  }

  // Điều chỉnh getAllPost để phát trực tiếp List<dynamic>
  Stream<List<dynamic>> getAllPost() async* {
    while (true) {
      yield await fetchAllPost();
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  Future<void> pickImages() async {
    if (picker != null) {
      final pickedFiles = await picker.pickMultiImage();
      state.selectedImages.value =
          pickedFiles.map((e) => File(e.path)).toList();
    } else {
      print("Image picker is already active");
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}


// class PostController extends GetxController {
//   final state = PostState();
//   final textController = TextEditingController();
//   final ImagePicker picker = ImagePicker();

//   // void postMessage() async {
//   //   if (textController.value.text.isNotEmpty ||
//   //       state.selectedImages.isNotEmpty) {
//   //     List<String> imageUrls = await uploadImages(state.selectedImages);
//   //     FirebaseFirestore.instance.collection("User Post").add({
//   //       "Message": textController.text,
//   //       "UserID": APIsBase.currentUser.userId,
//   //       "Timestamp": Timestamp.now(),
//   //       "Likes": [],
//   //       "ImageUrls": imageUrls
//   //     });

//   //     textController.clear();
//   //     state.selectedImages.clear();
//   //   } else {
//   //     Get.snackbar('Error', 'Message or images cannot be empty');
//   //   }
//   // }

//   Future<Map<String, dynamic>> fetchAllPost() async {
//     final response = await http.get(Uri.parse(allPostURL));

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load post');
//     }
//   }

//   Stream<Map<String, dynamic>> getAllPost() async* {
//     while (true) {
//       yield await fetchAllPost();
//       await Future.delayed(
//           const Duration(seconds: 1)); // Thời gian delay giữa các lần cập nhật
//     }
//   }

//   Future<void> pickImages() async {
//     if (picker != null) {
//       final pickedFiles = await picker.pickMultiImage();
//       state.selectedImages.value =
//           pickedFiles.map((e) => File(e.path)).toList();
//     } else {
//       print("Image picker is already active");
//     }
//   }

//   // Future<List<String>> uploadImages(List<File> images) async {
//   //   List<String> downloadUrls = [];
//   //   for (var image in images) {
//   //     String fileName = path.basename(image.path);
//   //     Reference ref = FirebaseStorage.instance.ref().child('uploads/$fileName');
//   //     UploadTask uploadTask = ref.putFile(image);
//   //     TaskSnapshot snapshot = await uploadTask;
//   //     String downloadUrl = await snapshot.ref.getDownloadURL();
//   //     downloadUrls.add(downloadUrl);
//   //   }
//   //   return downloadUrls;
//   // }

//   @override
//   void onClose() {
//     textController.dispose();
//     super.onClose();
//   }
// }
