import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInfos {
  final String name;
  final String photoURL;
  final String userId;

  UserInfos({required this.name, required this.photoURL, required this.userId});

  @override
  String toString() {
    return 'UserInfos(name: $name, photoURL: $photoURL,userId: $userId )';
  }
}

final userInfosProvider = StateProvider<UserInfos?>((ref) => null);
