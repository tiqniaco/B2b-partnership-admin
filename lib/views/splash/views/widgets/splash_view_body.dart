import '/app_routes.dart';
import '/core/services/app_prefs.dart';

import '/core/constants/app_constants.dart';
import '/core/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sliding_logo.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slidingAnimation;

  @override
  initState() {
    super.initState();
    _initAnimationControllers();

    _navigateToNext();

    Get.find<NotificationsService>().initialize();
    Get.find<AppPreferences>().init();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlidingLogo(slidingAnimation: _slidingAnimation),
    );
  }

  Future<void> _navigateToNext() async {
    Future.delayed(kSplashDuration, () {
      if (Get.find<AppPreferences>().getToken() != "") {
        Get.offNamed(AppRoutes.adminHomeLayout);
      } else {
        Get.offNamed(AppRoutes.login);
      }
    });
  }

  void _initAnimationControllers() {
    _animationController = AnimationController(
      vsync: this,
      duration: kSplashAnimationDuration,
    );

    _slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: const Offset(0, 0),
    ).animate(_animationController);

    _animationController.forward();
  }
}
