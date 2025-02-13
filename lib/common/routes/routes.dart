import 'package:e_learning_app/common/routes/app_routes_name.dart';
import 'package:e_learning_app/features/application/view/application.dart';
import 'package:e_learning_app/features/sign_in/view/sign_in.dart';
import 'package:e_learning_app/features/sign_up/view/sign_up.dart';
import 'package:e_learning_app/features/welcome/view/welcome_page.dart';
import 'package:e_learning_app/global.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppPages {
  static List<dynamic> routes() {
    return [
      RouteEntity(path: AppRoutesName.WELCOME, page: Welcome()),
      RouteEntity(path: AppRoutesName.SIGN_IN, page: const SignIn()),
      RouteEntity(path: AppRoutesName.REGISTER, page: const SignUp()),
      RouteEntity(path: AppRoutesName.APPLICATION, page: const Application())
    ];
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (kDebugMode) {
      print("Current route: ${settings.name}");
    }

    if(settings.name != null) {
      var result = routes().where((element) => element.path == settings.name);
      if(result.isNotEmpty) {
        // check if user open app first time or not
        bool deviceFirstTime = Global.storageService.getDeviceFirstOpen();
        // print(deviceFirstTime);

        if(result.first.path == AppRoutesName.WELCOME && deviceFirstTime) {
          // check user log in or not
          bool isLogIn = Global.storageService.isLogIn();
          if(isLogIn) {
            return MaterialPageRoute(
                builder: (_) => const Application(),
                settings: settings);
          } else {
            return MaterialPageRoute(
                builder: (_) => const SignIn(),
                settings: settings);
          }
          // return MaterialPageRoute(
          //     builder: (_) => const SignIn(),
          //     settings: settings);
        } else {
          if (kDebugMode) {
            print("App run first time!");
          }
          return MaterialPageRoute(
              builder: (_) => result.first.page,
              settings: settings);
        }
      }
    }

    return MaterialPageRoute(
        builder: (_) => Welcome(),
        settings: settings);
  }
}

class RouteEntity {
  String path;
  Widget page;

  RouteEntity({required this.path, required this.page});
}
