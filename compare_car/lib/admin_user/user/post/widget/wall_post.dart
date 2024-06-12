import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../../../../common/config/config.dart';
import '../../../../common/entities/user.dart';
import '../../../../common/store/user.dart';
import '../../../../common/widgets/comment_button.dart';
import '../../../../common/widgets/like_button.dart';
import 'post_detail_page.dart';
import 'view_image.dart';

class WallPost extends StatefulWidget {
  final String content;
  final String title;
  final String user;
  final String postId;
  // final String time;
  final List<String> likes;
  final List<String> imageUrls;
  final int numberOfComments;
  final int numberOfLikes;

  const WallPost({
    Key? key,
    required this.content,
    required this.title,
    required this.user,
    required this.postId,
    required this.likes,
    // required this.time,
    required this.imageUrls,
    required this.numberOfComments,
    required this.numberOfLikes,
  }) : super(key: key);

  @override
  _WallPostState createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  late UserDB user; // Biến lưu trữ thông tin người dùng
  bool isLiked = false;
  int commentCount = 0;
  final commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeUser(); // Khởi tạo dữ liệu người dùng và kiểm tra "like"// Theo dõi số lượng bình luận
  }

  // Hàm khởi tạo dữ liệu người dùng
  Future<void> _initializeUser() async {
    final profileJson = await UserDBStore.to.getProfile();
    user = UserDB.fromJson(jsonDecode(profileJson));
    _checkLikeStatus();
  }

  // Hàm kiểm tra trạng thái "like"
  Future<void> _checkLikeStatus() async {
    try {
      final isPostLiked = await checkLiked(widget.postId);
      setState(() {
        isLiked = isPostLiked;
      });
    } catch (e) {
      print('Error checking like status: $e');
    }
  }

  // Hàm gửi yêu cầu kiểm tra trạng thái "like" từ API
  Future<bool> checkLiked(String idPost) async {
    final body = json.encode({
      'idPost': idPost,
      'idUser': user.id,
    });

    final response = await http.post(
      Uri.parse(checkLikeURL),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data["isLiked"] == "true";
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future toggleLiked() async {
    setState(() {
      isLiked = !isLiked;
    });
    final body = json.encode({
      'idPost': widget.postId,
      'idUser': user.id,
    });

    final response = await http.post(
      Uri.parse(checkLikeURL),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    return json.decode(response.body);
  }

  void viewImage(BuildContext context, String imageUrl) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => FullScreenImage(imageUrl: imageUrl),
    ));
  }

  // void navigateToPostDetail() {
  //   Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => PostDetailPage(
  //       postId: widget.postId,
  //       message: widget.content,
  //       user: widget.user,
  //       time: widget.time,
  //       likes: widget.likes,
  //       imageUrls: widget.imageUrls,
  //     ),
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25), // màu sắc của bóng đổ
              spreadRadius: 2, // độ lan rộng của bóng
              blurRadius: 5, // độ mờ của bóng
              offset: const Offset(0, 3), // vị trí của bóng (x, y)
            ),
          ],
        ),
        margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.user,
                              style: const TextStyle(
                                  color: Color.fromRGBO(32, 34, 68, 1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 5),
                            // Text(widget.time,
                            //     style: const TextStyle(
                            //         color: Color.fromRGBO(122, 122, 122, 1),
                            //         fontSize: 10,
                            //         fontWeight: FontWeight.w300)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      widget.content,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                  ],
                ),
                // if (widget.user == APIsBase.currentUser.fName)
                //   DeleteButton(onTap: deletePost),
              ],
            ),
            const SizedBox(height: 20),
            if (widget.imageUrls.isNotEmpty)
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.imageUrls.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        viewImage(context, widget.imageUrls[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(widget.imageUrls[index]),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LikeButton(isLiked: isLiked, onTap: toggleLiked),
                      const SizedBox(width: 5),
                      Text(
                        widget.numberOfLikes.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CommentButton(onTap: () {}),
                      const SizedBox(width: 5),
                      const Text("Bình luận"),
                      const SizedBox(width: 5),
                      Text(
                        widget.numberOfComments.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            )
            // StreamBuilder<QuerySnapshot>(
            //   stream: FirebaseFirestore.instance
            //       .collection("User Post")
            //       .doc(widget.postId)
            //       .collection("Comments")
            //       .orderBy("CommentTime", descending: true)
            //       .snapshots(),
            //   builder: (context, snapshot) {
            //     if (!snapshot.hasData) {
            //       return const Center(child: CircularProgressIndicator());
            //     }
            //     return ListView(
            //       shrinkWrap: true,
            //       physics: const NeverScrollableScrollPhysics(),
            //       children: snapshot.data!.docs.map((doc) {
            //         final commentData = doc.data() as Map<String, dynamic>;
            //         return Comment(
            //           text: commentData["CommentText"],
            //           time: formatData(commentData["CommentTime"]),
            //           user: commentData["CommentedBy"],
            //         );
            //       }).toList(),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
