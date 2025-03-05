import 'package:e_learning_app/common/global_loader/global_loader.dart';
import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:e_learning_app/common/utils/image_resources.dart';
import 'package:e_learning_app/common/widgets/app_bar.dart';
import 'package:e_learning_app/common/widgets/app_text_fields.dart';
import 'package:e_learning_app/common/widgets/button_widgets.dart';
import 'package:e_learning_app/common/widgets/text_widgets.dart';
import 'package:e_learning_app/features/sign_in/controller/sign_in_controller.dart';
import 'package:e_learning_app/features/sign_in/controller/sign_in_notifier.dart';
import 'package:e_learning_app/features/sign_in/view/widgets/sign_in_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({super.key});

  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  late SignInController _controller;

  // @override
  // void initState() {
  //   _controller = SignInController();
  //
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    _controller = SignInController();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final signInProvider = ref.watch(signInNotifierProvider);
    final loader = ref.watch(appLoaderProvider);

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            appBar: buildAppbar(title: 'Login'),
            backgroundColor: Colors.white,
            body: loader==false?SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // login options
                  thirdPartyLogin(),
                  Center(
                      child: TextNormal(
                          text: 'Or use your email account to login',
                          color: AppColors.primarySecondaryElementText,
                          fontSize: 16)),
                  SizedBox(
                    height: 50.h,
                  ),
                  // email input area
                  appTextField(
                    controller: _controller.emailController,
                      text: 'Email',
                      iconName: ImageResources.userIcon,
                      hintText: 'Enter your email',
                      func: (value) => ref
                          .read(signInNotifierProvider.notifier)
                          .onUserEmailChange(value)),
                  SizedBox(
                    height: 20.h,
                  ),
                  // password input area
                  appTextField(
                      controller: _controller.passwordController,
                      text: 'Password',
                      iconName: ImageResources.lockIcon,
                      hintText: 'Enter your password',
                      obscureText: true,
                      func: (value) => ref
                          .read(signInNotifierProvider.notifier)
                          .onUserPasswordChange(value)),
                  SizedBox(height: 20.h),
                  // forgot pw link
                  Container(
                      margin: EdgeInsets.only(left: 25.w),
                      child: textUnderline(text: 'Forgot password?')),
                  SizedBox(height: 100.h),
                  // login btn
                  Center(
                      child: appButton(
                          buttonName: 'Login',
                          func: () => _controller.handleSignIn(ref))),
                  SizedBox(height: 20.h),
                  // register btn
                  Center(
                      child: appButton(
                          buttonName: 'Register',
                          isLogin: false,
                          context: context,
                          func: () =>
                              Navigator.pushNamed(context, '/register')))
                ],
              ),
            ):const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                  color: AppColors.primaryElement,
                )
            )),
      ),
    );
  }
}
