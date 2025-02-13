import 'package:e_learning_app/common/entities/entities.dart';
import 'package:e_learning_app/common/global_loader/global_loader.dart';
import 'package:e_learning_app/common/utils/constants.dart';
import 'package:e_learning_app/common/widgets/popup_messages.dart';
import 'package:e_learning_app/features/sign_in/provider/sign_in_notifier.dart';
import 'package:e_learning_app/features/sign_in/repo/sign_in_repo.dart';
import 'package:e_learning_app/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInController {
  WidgetRef ref;

  SignInController({required this.ref});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> handleSignIn() async {
    var state = ref.read(signInNotifierProvider);

    String email = state.email;
    String password = state.password;

    emailController.text = email;
    passwordController.text = password;

    if (state.email.isEmpty || email.isEmpty) {
      toastInfo('Your email is empty!');
      return;
    }

    if (state.password.isEmpty || password.isEmpty) {
      toastInfo('Your password is empty!');
      return;
    }

    ref.read(appLoaderProvider.notifier).setLoaderValue(true);
    try {
      final credential = await SignInRepo.firebaseSignIn(email, password);

      if (credential.user == null) {
        toastInfo('User not found!');
        return;
      }
      if (!credential.user!.emailVerified) {
        toastInfo('You must verify your email address first!');
        return;
      }

      var user = credential.user;

      if (user != null) {
        String? displayName = user.displayName;
        String? email = user.email;
        String? id = user.uid;
        String? photoUrl = user.photoURL;

        LoginRequestEntity loginRequestEntity = LoginRequestEntity();
        loginRequestEntity.avatar = photoUrl;
        loginRequestEntity.name = displayName;
        loginRequestEntity.email = email;
        loginRequestEntity.openId = id;
        loginRequestEntity.type = 1;
        asyncPostAllData(loginRequestEntity);
      } else {
        toastInfo("Login error!");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        toastInfo('User is not found!');
      } else if (e.code == 'wrong-password') {
        toastInfo('Your password is wrong!');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    ref.read(appLoaderProvider.notifier).setLoaderValue(false);
  }

  void asyncPostAllData(LoginRequestEntity loginRequestEntity) {
    // request to server

    // local storage
    try {
      var navigator = Navigator.of(ref.context);
      // save user info
      Global.storageService
          .setString(AppConstants.STORAGE_USER_PROFILE_KEY, "123");
      Global.storageService
          .setString(AppConstants.STORAGE_USER_TOKEN_KEY, "123456");

      navigator.pushNamedAndRemoveUntil("/application", (route) => false);
      // navigator.push(MaterialPageRoute(
      //     builder: (BuildContext context) => Scaffold(
      //           appBar: AppBar(),
      //           body: const Application(),
      //         )));
      // navigator.pushNamed("/application");
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    // redirect
  }
}
