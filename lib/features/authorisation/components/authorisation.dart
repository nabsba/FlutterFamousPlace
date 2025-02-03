import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/error/components/error.dart';
// import 'package:flutter_famous_places/pages/signIn/sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../pages/signIn/sign_in.dart';
import '../../authentification/services/authentication.dart';

import '../../client/providers/clientProvider.dart';
import '../../common/services/variables.dart';
import '../../connectivityState/components/WidgetNotConnected.dart';
import '../../connectivityState/providers/connectivityHelper.dart';
import '../../graphql/services/response.dart';
import '../../success/services/success.dart';
import '../offline/services/functions.dart';

class AuthorizationWrapper extends ConsumerWidget {
  final Widget signedInWidget;
  const AuthorizationWrapper({
    super.key,
    required this.signedInWidget,
  });

  void updateUserInfos(
      WidgetRef ref, String name, String photoURL, String userId) {
    ref.read(userInfosProvider.notifier).state =
        UserInfos(name: name, photoURL: photoURL, userId: userId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityState = ref.watch(connectivityProvider);

    return connectivityState.when(
      data: (isConnected) {
        // Handle the case when the data (connection status) is available
        if (isConnected) {
          return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData && snapshot.data != null) {
                final user = snapshot.data!;
                AuthenticationClass authenticationClass = AuthenticationClass();
                return FutureBuilder<ResponseGraphql<String>>(
                  future: authenticationClass.handleAuthentification(
                      _mapUserToData(user)), // The future you are waiting for
                  builder: (context, tokenSnapshot) {
                    // Check the connection state of the future
                    if (tokenSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (tokenSnapshot.hasError) {
                      return ErrorComponent(errorKey: 'defaultError');
                    }

                    if (tokenSnapshot.hasData) {
                      final result = tokenSnapshot.data!;
                      if (result.status == successStatus['OK'] &&
                          !result.isError) {
                        Future(() {
                          updateUserInfos(ref, user.displayName ?? defaultName,
                              user.photoURL!, user.providerData[0].uid!);
                          UserInfosCRUD().handleAddNewUser(UserInfos(
                              name: user.displayName ?? defaultName,
                              photoURL: user.photoURL!,
                              userId: user.providerData[0].uid!));
                        });
                        return signedInWidget;
                      } else {
                        return ErrorComponent(errorKey: result.messageKey);
                      }
                    }
                    return ErrorComponent(errorKey: 'defaultError');
                  },
                );
              } else {
                return SignIn();
              }
            },
          );
        } else {
          return FutureBuilder<List<UserInfos>>(
            future: UserInfosCRUD()
                .getAllUsers(), // Fetch user infUserInfosCRUD asynchronously
            builder: (context, userInfoSnapshot) {
              if (userInfoSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (userInfoSnapshot.hasError) {
                return Center(child: Text('Error: ${userInfoSnapshot.error}'));
              }

              if (userInfoSnapshot.hasData &&
                  userInfoSnapshot.data != null &&
                  userInfoSnapshot.data!.isNotEmpty) {
                final userInfo = userInfoSnapshot.data!;

                Future(() {
                  // !toImplementForTheNextVersionOfTheApp
                  // This version of this simple APP considers that there is only one profile on the mobile used. In case of many, consider displaying multi profile to be selected by the owner or provide a pin code during the registration and ask for it to retrieve the right profile and update from there the userInfo
                  updateUserInfos(
                      ref,
                      userInfo[0].name.isNotEmpty
                          ? userInfo[0].name
                          : defaultName,
                      userInfo[0].photoURL,
                      userInfo[0].userId);
                });

                return signedInWidget;
              } else {
                return NotConnectedWidget();
              }
            },
          );
        }
      },
      loading: () {
        // Show a loading widget while waiting for the data
        return Center(child: CircularProgressIndicator());
      },
      error: (error, stackTrace) {
        // Handle error state
        return Center(child: Text('Error: $error'));
      },
    );
  }

  Map<String, dynamic> _mapUserToData(User user) {
    return {
      'id': user.providerData[0].uid,
      'userName': user.displayName,
      'email': user.providerData[0].email,
      'provider': user.providerData[0].providerId,
      'type': "providers",
      'providerAccountId': user.providerData[0].providerId,
    };
  }
}
