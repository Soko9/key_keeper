import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:key_keeper/src/app/views/screens/home_screen.dart';
import '../core/errors/network_failed_screen.dart';

import '../app/views/screens/screens.dart';

// enum PageTransitionAnimation { fade, slide, scale, none }

// abstract class AppNavigation {
//   static const PageTransitionAnimation _transitionAnimation =
//       PageTransitionAnimation.none;
//   static const Duration _transitionDuration = Duration(milliseconds: 250);

//   static Route generateRoutes(RouteSettings settings) {
//     final Widget page = switch (settings.name) {
//       AuthScreen.routeName => const AuthScreen(),
//       HomeScreen.routeName => const HomeScreen(),
//       _ => const WrongRouteScreen(),
//     };

//     switch (_transitionAnimation) {
//       case PageTransitionAnimation.fade:
//         return PageRouteBuilder(
//           pageBuilder: (_, __, ___) => page,
//           transitionsBuilder: (_, animation, __, child) => FadeTransition(
//             opacity: animation,
//             child: child,
//           ),
//           transitionDuration: _transitionDuration,
//           reverseTransitionDuration: _transitionDuration,
//         );
//       case PageTransitionAnimation.slide:
//         return PageRouteBuilder(
//           pageBuilder: (_, __, ___) => page,
//           transitionsBuilder: (_, animation, __, child) => SlideTransition(
//             position: Tween<Offset>(
//               begin: const Offset(1.0, 0.0),
//               end: Offset.zero,
//             ).animate(animation),
//             child: child,
//           ),
//           transitionDuration: _transitionDuration,
//           reverseTransitionDuration: _transitionDuration,
//         );
//       case PageTransitionAnimation.scale:
//         return PageRouteBuilder(
//           pageBuilder: (_, __, ___) => page,
//           transitionsBuilder: (_, animation, __, child) => ScaleTransition(
//             scale: Tween<double>(
//               begin: 0.0,
//               end: 1.0,
//             ).animate(animation),
//             child: child,
//           ),
//           transitionDuration: _transitionDuration,
//           reverseTransitionDuration: _transitionDuration,
//         );
//       case PageTransitionAnimation.none:
//         return MaterialPageRoute(builder: (_) => page);
//     }
//   }
// }

abstract class AppNavigation {
  static const Transition _transition = Transition.size;
  static const Cubic _curve = Curves.ease;
  static const Duration _transitionDuration = Duration(milliseconds: 250);

  static final List<GetPage> pages = [
    GetPage(
      name: NetworkFailedScreen.routeName,
      page: () => const NetworkFailedScreen(),
      transition: _transition,
      transitionDuration: _transitionDuration,
      curve: _curve,
    ),
    GetPage(
      name: AuthScreen.routeName,
      page: () => const AuthScreen(),
      transition: _transition,
      transitionDuration: _transitionDuration,
      curve: _curve,
    ),
    GetPage(
      name: RecoverySscreen.routeName,
      page: () => const RecoverySscreen(),
      transition: _transition,
      transitionDuration: _transitionDuration,
      curve: _curve,
    ),
    GetPage(
      name: HomeScreen.routeName,
      page: () => const HomeScreen(),
      transition: _transition,
      transitionDuration: _transitionDuration,
      curve: _curve,
    ),
    GetPage(
      name: TermsScreen.routeName,
      page: () => const TermsScreen(),
      transition: _transition,
      transitionDuration: _transitionDuration,
      curve: _curve,
    ),
  ];
}
