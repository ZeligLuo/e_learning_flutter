import 'package:e_learning_app/common/utils/app_color.dart';
import 'package:e_learning_app/common/widgets/app_bar.dart';
import 'package:e_learning_app/common/widgets/app_shadow.dart';
import 'package:e_learning_app/features/application/provider/application_nav_notifier.dart';
import 'package:e_learning_app/features/application/view/widgets/application_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Application extends ConsumerWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int index = ref.watch(applicationNavIndexProvider);

    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
            body: appScreens(index: index),
            bottomNavigationBar: Container(
              width: 375.w,
              height: 58.h,
              decoration: appBoxShadowWithRadiusTop(),
              child: BottomNavigationBar(
                currentIndex: index,
                onTap: (value) {
                  ref.read(applicationNavIndexProvider.notifier).changeIndex(value);
                },
                elevation: 0,
                items: bottomTabs,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedItemColor: AppColors.primaryElement,
                unselectedItemColor: AppColors.primaryFourthElementText,
              ),
            ),
          )),
    );
  }
}

