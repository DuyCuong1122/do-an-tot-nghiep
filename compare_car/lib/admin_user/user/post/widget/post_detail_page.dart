// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'view_image.dart';

// class PostDetailPage extends StatefulWidget {
//   final String postId;
//   final String message;
//   final String user;
//   final String time;
//   final List<String> likes;
//   final List<String> imageUrls;

//   const PostDetailPage({
//     Key? key,
//     required this.postId,
//     required this.message,
//     required this.user,
//     required this.time,
//     required this.likes,
//     required this.imageUrls,
//   }) : super(key: key);

//   @override
//   _PostDetailPageState createState() => _PostDetailPageState();
// }

// class _PostDetailPageState extends State<PostDetailPage> {
//   int commentCount = 0;
//   bool isLiked = false;
//   final TextEditingController commentTextController = TextEditingController();
//   bool _isSendButtonVisible = false;

//   @override
//   void initState() {
//     super.initState();
//     isLiked = widget.likes.contains(APIsBase.currentUser.fName);
//     FirebaseFirestore.instance
//         .collection("User Post")
//         .doc(widget.postId)
//         .collection("Comments")
//         .snapshots()
//         .listen((snapshot) {
//       setState(() {
//         commentCount = snapshot.docs.length;
//       });
//     });

//     // Lắng nghe thay đổi trong TextField để cập nhật trạng thái của nút gửi
//     commentTextController.addListener(() {
//       setState(() {
//         _isSendButtonVisible = commentTextController.text.isNotEmpty;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     // Giải phóng bộ nhớ khi không cần thiết nữa
//     commentTextController.dispose();
//     super.dispose();
//   }

//   void toggleLiked() {
//     setState(() {
//       isLiked = !isLiked;
//     });

//     DocumentReference postRef =
//         FirebaseFirestore.instance.collection("User Post").doc(widget.postId);

//     if (isLiked) {
//       postRef.update({
//         "Likes": FieldValue.arrayUnion([APIsBase.currentUser.fName])
//       });
//     } else {
//       postRef.update({
//         "Likes": FieldValue.arrayRemove([APIsBase.currentUser.fName])
//       });
//     }
//   }

//   void addComment(String commentText) {
//     FirebaseFirestore.instance
//         .collection("User Post")
//         .doc(widget.postId)
//         .collection("Comments")
//         .add({
//       "CommentText": commentText,
//       "CommentedBy": APIsBase.currentUser.fName,
//       "CommentTime": Timestamp.now()
//     });
//   }

//   void viewImage(BuildContext context, String imageUrl) {
//     Navigator.of(context).push(MaterialPageRoute(
//       builder: (context) => FullScreenImage(imageUrl: imageUrl),
//     ));
//   }

//   void showCommentDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Add comment"),
//         content: TextField(
//           decoration: const InputDecoration(hintText: "Write a comment ..."),
//           controller: commentTextController,
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               commentTextController.clear();
//             },
//             child: const Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () {
//               addComment(commentTextController.text);
//               commentTextController.clear();
//               Navigator.pop(context);
//             },
//             child: const Text("Post"),
//           ),
//         ],
//       ),
//     );
//   }

//   void deletePost() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Delete Post"),
//         content: const Text("Are you sure you want to delete this post?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () async {
//               final commentDocs = await FirebaseFirestore.instance
//                   .collection("User Post")
//                   .doc(widget.postId)
//                   .collection("Comments")
//                   .get();
//               for (var doc in commentDocs.docs) {
//                 await FirebaseFirestore.instance
//                     .collection("User Post")
//                     .doc(widget.postId)
//                     .collection("Comments")
//                     .doc(doc.id)
//                     .delete();
//               }
//               FirebaseFirestore.instance
//                   .collection("User Post")
//                   .doc(widget.postId)
//                   .delete()
//                   .then((value) => print("Post deleted"))
//                   .catchError((e) => print("Failed to delete post: $e"));
//               Navigator.pop(context);
//             },
//             child: const Text("Delete"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Post Detail"),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
//               padding: const EdgeInsets.only(
//                   top: 15, left: 15, right: 15, bottom: 5),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               const CircleAvatar(
//                                 radius: 20,
//                                 backgroundColor: Colors.grey,
//                                 child: Icon(
//                                   Icons.person,
//                                   size: 30,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 15,
//                               ),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     widget.user,
//                                     style: const TextStyle(
//                                         color: Color.fromRGBO(32, 34, 68, 1),
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.w700),
//                                   ),
//                                   const SizedBox(height: 5),
//                                   Text(widget.time,
//                                       style: const TextStyle(
//                                           color:
//                                               Color.fromRGBO(122, 122, 122, 1),
//                                           fontSize: 10,
//                                           fontWeight: FontWeight.w300)),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 15),
//                           Text(
//                             widget.message,
//                             style: const TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w300,
//                                 color: Colors.black),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   if (widget.imageUrls.isNotEmpty)
//                     SizedBox(
//                       height: 200,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: widget.imageUrls.length,
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                             onTap: () {
//                               viewImage(context, widget.imageUrls[index]);
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Image.network(widget.imageUrls[index]),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   const SizedBox(height: 20),
//                   Container(
//                     decoration: const BoxDecoration(
//                         border: Border.symmetric(
//                             horizontal: BorderSide(
//                                 color: Color.fromRGBO(197, 194, 194, 1)))),
//                     padding: const EdgeInsets.only(top: 10, bottom: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               LikeButton(isLiked: isLiked, onTap: toggleLiked),
//                               const SizedBox(width: 5),
//                               Text(
//                                 widget.likes.length.toString(),
//                                 style: const TextStyle(color: Colors.black),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               CommentButton(onTap: showCommentDialog),
//                               const SizedBox(width: 5),
//                               const Text("Bình luận"),
//                               const SizedBox(width: 5),
//                               Text(
//                                 "(${commentCount.toString()})",
//                                 style: const TextStyle(color: Colors.black),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collection("User Post")
//                         .doc(widget.postId)
//                         .collection("Comments")
//                         .orderBy("CommentTime", descending: true)
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (!snapshot.hasData) {
//                         return const Center(child: CircularProgressIndicator());
//                       }
//                       return ListView(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         children: snapshot.data!.docs.map((doc) {
//                           final commentData =
//                               doc.data() as Map<String, dynamic>;
//                           return Comment(
//                             time: formatData(commentData["CommentTime"]),
//                             text: commentData["CommentText"],
//                             user: commentData["CommentedBy"],
//                           );
//                         }).toList(),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: commentTextController,
//                     decoration: InputDecoration(
//                       hintText: 'Viết bình luận...',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 16, vertical: 10),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 if (commentTextController.text.isNotEmpty)
//                   IconButton(
//                     icon: const Icon(Icons.send),
//                     onPressed: () {
//                       if (_isSendButtonVisible) {
//                         addComment(commentTextController.text);
//                         commentTextController.clear();
//                       }
//                     },
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
