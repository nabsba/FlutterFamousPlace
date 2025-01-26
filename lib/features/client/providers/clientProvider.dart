import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfos {
  final String name;
  final String photoURL;
  final String userId;

  UserInfos({required this.name, required this.photoURL, required this.userId});

  // Convert a UserInfos object to a Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'photoURL': photoURL,
      'userId': userId,
    };
  }

  // Convert a Map to a UserInfos object
  factory UserInfos.fromMap(Map<String, dynamic> map) {
    return UserInfos(
      name: map['name'],
      photoURL: map['photoURL'],
      userId: map['userId'],
    );
  }

  @override
  String toString() {
    return 'UserInfos(name: $name, photoURL: $photoURL,userId: $userId )';
  }
}

final userInfosProvider = StateProvider<UserInfos?>((ref) => null);
