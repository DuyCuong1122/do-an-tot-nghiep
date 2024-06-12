import 'package:cloud_firestore/cloud_firestore.dart';

class UserDB {
  final String? id;
  final String? username;
  final String? email;
  final List<String>? roles;
  final String? access_token;
  final String? displayName;

  UserDB({
    this.id,
    this.username,
    this.email,
    this.roles,
    this.access_token,
    this.displayName,
  });

  factory UserDB.fromJson(Map<String, dynamic> json) {
    var streetsFromJson = json['roles'];
    List<String> roles =
        streetsFromJson != null ? List<String>.from(streetsFromJson) : [];

    return UserDB(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      roles: roles,
      access_token: json["access_token"],
      displayName: json["displayName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'roles': roles,
      'access_token': access_token,
      'displayName': displayName,
    };
  }
}

class UserData {
  final String? id;
  final String? username;
  final String? name;
  final String? email;
  final String? photourl;
  final String? fcmtoken;
  final Timestamp? addtime;

  UserData({
    this.id,
    this.username,
    this.name,
    this.email,
    this.photourl,
    this.fcmtoken,
    this.addtime,
  });

  factory UserData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserData(
      id: data?['id'],
      name: data?['name'],
      email: data?['email'],
      photourl: data?['photourl'],
      username: "",
      fcmtoken: data?['fcmtoken'],
      addtime: data?['addtime'],
    );
  }
}

// 登录返回
class UserLoginResponseEntity {
  String? accessToken;
  String? displayName;
  String? email;
  String? photoUrl;

  UserLoginResponseEntity({
    this.accessToken,
    this.displayName,
    this.email,
    this.photoUrl,
  });

  factory UserLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginResponseEntity(
        accessToken: json["access_token"],
        displayName: json["display_name"],
        email: json["email"],
        photoUrl: json["photoUrl"] ??
            "https://d1hjkbq40fs2x4.cloudfront.net/2016-01-31/files/1045.jpg",
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "display_name": displayName,
        "email": email,
        "photoUrl": photoUrl,
      };
  printALl() {
    print(
        'accessToken: $accessToken, displayName: $displayName, email: $email, photoUrl: $photoUrl');
  }
}
