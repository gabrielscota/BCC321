import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/home/home.dart';
import 'app/product_details/product_details.dart';
import 'app/sign_in/sign_in.dart';
import 'app/sign_up/sign_up.dart';
import 'app/splash/splash.dart';

class AppRoutes {
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String splash = '/';
  static const String home = '/home';
  static const String product = '/product';

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter routes = GoRouter(
    initialLocation: AppRoutes.splash,
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.signIn,
        builder: (context, state) => BlocProvider(
          create: (context) => SignInBloc(
            signInUseCase: SignInUseCase(
              repository: SupabaseSignInRepository(client: Supabase.instance.client),
            ),
          ),
          child: const SignInPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => BlocProvider(
          create: (context) => SignUpBloc(
            signUpUseCase: SignUpUseCase(
              repository: SupabaseSignUpRepository(client: Supabase.instance.client),
            ),
          ),
          child: const SignInPage(),
        ),
      ),
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
            create: (context) {
              final supabaseClient = Supabase.instance.client;
              return HomeBloc(
                fetchCategoryListUseCase: FetchCategoryListUseCase(
                  repository: SupabaseCategoryRepository(client: supabaseClient),
                ),
                fetchProductListUseCase: FetchProductListUseCase(
                  repository: SupabaseProductRepository(client: supabaseClient),
                ),
              );
            },
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
        path: '${AppRoutes.product}/:productId',
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 200),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          child: BlocProvider(
            create: (context) => ProductDetailsBloc(
              fetchProductDetailsUseCase: FetchProductDetailsUseCase(
                repository: SupabaseProductDetailsRepository(client: Supabase.instance.client),
              ),
            ),
            child: ProductDetailsPage(productId: state.pathParameters['productId']!),
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
