import 'package:e_learning_app/common/global_loader/global_loader.dart';
import 'package:e_learning_app/common/widgets/popup_messages.dart';
import 'package:e_learning_app/features/sign_up/controller/register_notifier.dart';
import 'package:e_learning_app/features/sign_up/repo/sign_up_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpController {
  late WidgetRef ref;

  SignUpController({required this.ref});

  Future<void> handleSignUp() async {
    var state = ref.read(registerNotifierProvider);

    String name = state.userName;
    String email = state.email;

    String password = state.password;
    String cfPassword = state.cfPassword;

    if (state.userName.isEmpty || name.isEmpty) {
      toastInfo('Your name is empty!');
      return;
    }

    if (state.userName.length < 6 || name.length < 6) {
      toastInfo('Your name is too short!');
      return;
    }

    if (state.email.isEmpty || email.isEmpty) {
      toastInfo('Your email is empty!');
      return;
    }

    if (state.password.isEmpty ||
        state.cfPassword.isEmpty ||
        password.isEmpty ||
        cfPassword.isEmpty) {
      toastInfo('Your password is empty!');
      return;
    }

    if (state.password != state.cfPassword || password != cfPassword) {
      toastInfo('Your password did not match!');
      return;
    }

    // show loading icon
    ref.read(appLoaderProvider.notifier).setLoaderValue(true);

    var context = Navigator.of(ref.context);

    try {
      final credential = await SignUpRepo.firebaseSignUp(email, password);

      if(kDebugMode) {
        print(credential);
      }

      if(credential.user != null) {

        await credential.user?.sendEmailVerification();
        await credential.user?.updateDisplayName(name);
        // get server photo url, set user photo url
        String photoUrl = "uploads/default.png";
        await credential.user?.updatePhotoURL(photoUrl);

        toastInfo("An email has been sent to verify your account!");
        context.pop();
      }
    } on FirebaseAuthException catch (e) {
        if(e.code == 'weak-password') {
          toastInfo('This password is too weak!');
          return;
        } else if(e.code == 'email-already-in-use') {
          toastInfo('This email address has already been registered!');
          return;
        }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    // show register screen
    ref.watch(appLoaderProvider.notifier).setLoaderValue(false);
  }
}
