import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/helper/helper_method.dart';
import 'controller.dart';
import 'widget/wall_post.dart';

class PostPage extends GetView<PostController> {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<dynamic>>(
                stream: controller.getAllPost(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    final posts = snapshot.data ?? [];
                    if (posts.isEmpty) {
                      return const Center(
                        child: Text("No posts available"),
                      );
                    }

                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];

                        return GestureDetector(
                          onTap: () {},
                          child: WallPost(
                            content: post["content"] ?? "No content",
                            user: post["displayName"] ?? "Unknown",
                            postId: post["_id"] ?? "No id",
                            title: post["title"] ?? "No title",
                            likes: List<String>.from(post["Likes"] ?? []),
                            // time: formatData(
                            //     post["createdAt"] ?? Timestamp.fromDate(DateTime.now())),
                            imageUrls:
                                List<String>.from(post["ImageUrls"] ?? []),
                            numberOfComments: post["numberOfComments"] ?? 0,
                            numberOfLikes: post["numberOfLikes"] ?? 0,
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("Unexpected error occurred"),
                    );
                  }
                },
              ),
            ),
            Obx(() {
              return controller.state.selectedImages.isNotEmpty
                  ? SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.state.selectedImages.length,
                        itemBuilder: (context, index) {
                          return Image.file(
                              controller.state.selectedImages[index]);
                        },
                      ),
                    )
                  : const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}
