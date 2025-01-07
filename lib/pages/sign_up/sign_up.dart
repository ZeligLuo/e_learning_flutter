import 'package:e_learning_app/common/global_loader/global_loader.dart';
import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:e_learning_app/common/widgets/app_bar.dart';
import 'package:e_learning_app/common/widgets/app_text_fields.dart';
import 'package:e_learning_app/common/widgets/button_widgets.dart';
import 'package:e_learning_app/common/widgets/text_widgets.dart';
import 'package:e_learning_app/pages/sign_up/notifier/register_notifier.dart';
import 'package:e_learning_app/pages/sign_up/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  late SignUpController _controller;

  @override
  void initState() {
    _controller = SignUpController(ref: ref);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final regProvider = ref.watch(registerNotifierProvider);

    final loader = ref.watch(appLoaderProvider);

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            appBar: buildAppbar(title: 'Sign Up'),
            backgroundColor: Colors.white,
            body: loader == false
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h),
                        Center(
                            child: text16Normal(
                                text:
                                    'Enter your details below & free sign up')),
                        SizedBox(
                          height: 50.h,
                        ),
                        // username input area
                        appTextField(
                            text: 'Username',
                            iconName: 'assets/icons/user.png',
                            hintText: 'Enter your username',
                            func: (value) => ref
                                .read(registerNotifierProvider.notifier)
                                .onUserNameChange(value)),
                        // password input area
                        SizedBox(
                          height: 20.h,
                        ),
                        // email input area
                        appTextField(
                            text: 'Email',
                            iconName: 'assets/icons/user.png',
                            hintText: 'Enter your email',
                            func: (value) => ref
                                .read(registerNotifierProvider.notifier)
                                .onUserEmailChange(value)),

                        SizedBox(
                          height: 20.h,
                        ),
                        // password input area
                        appTextField(
                            text: 'Password',
                            iconName: 'assets/icons/lock.png',
                            hintText: 'Enter your password',
                            obscureText: true,
                            func: (value) => ref
                                .read(registerNotifierProvider.notifier)
                                .onUserPasswordChange(value)),
                        SizedBox(height: 20.h),
                        appTextField(
                            text: 'Confirm Password',
                            iconName: 'assets/icons/lock.png',
                            hintText: 'Confirm your password',
                            obscureText: true,
                            func: (value) => ref
                                .read(registerNotifierProvider.notifier)
                                .onUserCfPasswordChange(value)),
                        SizedBox(height: 20.h),
                        // forgot pw link
                        Container(
                            margin: EdgeInsets.only(left: 25.w),
                            child: text14Normal(
                                text:
                                    'By creating an account you are agreeing with our terms and conditions')),
                        SizedBox(height: 100.h),
                        // register btn
                        Center(
                            child: appButton(
                                buttonName: 'Register',
                                isLogin: true,
                                context: context,
                                func: () => _controller.handleSignUp()))
                      ],
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                    backgroundColor: Colors.blue,
                    color: AppColors.primaryElement,
                  )
            )),
      ),
    );
  }
}