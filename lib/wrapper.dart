import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timberr/constants.dart';
import 'package:timberr/controllers/address_controller.dart';
import 'package:timberr/controllers/card_details_controller.dart';
import 'package:timberr/controllers/cart_controller.dart';
import 'package:timberr/controllers/favorites_controller.dart';
import 'package:timberr/controllers/home_controller.dart';
import 'package:timberr/controllers/user_controller.dart';
import 'package:timberr/screens/authentication/onboarding_welcome.dart';
import 'package:timberr/screens/authentication/splash_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key, required this.isAuth, required this.token});

  final String token;
  final bool isAuth;

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    if (!mounted) {
      return;
    }

    // final session = Supabase.instance.client.auth.currentSession;
    if (widget.isAuth) {
      Get.put(HomeController());
      Get.put(FavoritesController(token: widget.token));
      Get.put(CartController(token: widget.token));
      Get.put(UserController(token: widget.token));
      Get.put(AddressController(token: widget.token));
      Get.put(CardDetailsController(token: widget.token));
      Get.to(() => SplashScreen(), transition: Transition.fadeIn);
    } else {
      Get.off(() => const OnBoardingWelcomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator(color: kOffBlack)),
    );
  }
}
