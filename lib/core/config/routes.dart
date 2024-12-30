import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helpnest/features/auth/presentation/pages/onboarding_page.dart';
import 'package:helpnest/features/home/presentation/pages/home_controller.dart';

class AppRoutes {
  static const String core = '/';
  static const String onboardingPage = '/onboardingPage';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case core:
        if (FirebaseAuth.instance.currentUser != null) {
          return MaterialPageRoute(builder: (_) => const HomeController());
        } else {
          return MaterialPageRoute(builder: (_) => const OnboardingPage());
        }
      case home:
        return MaterialPageRoute(builder: (_) => const HomeController());
      case onboardingPage:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());

      // case consumerDetail:
      //   final args = settings.arguments as Map<String, dynamic>?;
      //   return MaterialPageRoute(
      //     builder: (_) => ConsumerDetailPage(
      //       consumer: args?['consumer'],
      //     ),
      //   );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(),
        );
    }
  }

  static Future<void> navigateTo(
      BuildContext context, String routeName, Object? arguments) {
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static Future<void> replaceWith(BuildContext context, String routeName) {
    return Navigator.pushReplacementNamed(context, routeName);
  }

  static void navigateBack(BuildContext context) {
    Navigator.pop(context);
  }

  static void navigateAndReplace(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }
}
