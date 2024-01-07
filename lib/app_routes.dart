import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'app/home/home.dart';
import 'app/product_details/product_details.dart';
import 'app/splash/splash.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String productDetails = '/product/details';

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter routes = GoRouter(
    initialLocation: AppRoutes.splash,
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => BlocProvider(
          create: (context) => SplashBloc(),
          child: const SplashPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 200),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          child: BlocProvider(
            create: (context) => HomeBloc(),
            child: const HomePage(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => CupertinoPageTransition(
            primaryRouteAnimation: animation,
            secondaryRouteAnimation: secondaryAnimation,
            linearTransition: true,
            child: child,
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.productDetails,
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 200),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          child: BlocProvider(
            create: (context) => ProductDetailsBloc(),
            child: const ProductDetailsPage(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => CupertinoPageTransition(
            primaryRouteAnimation: animation,
            secondaryRouteAnimation: secondaryAnimation,
            linearTransition: true,
            child: child,
          ),
        ),
      ),
    ],
    // redirect: (BuildContext context, GoRouterState state) {
    //   AppLoggedUserService.instance.onAuthStateChange.listen((event) {
    //     if (event.event == AuthChangeEvent.signedOut) {
    //       return context.go(AppRoutes.splash);
    //     } else {
    //       return;
    //     }
    //   });
    //   return;
    // },
  );
}
