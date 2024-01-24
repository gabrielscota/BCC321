import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/add_product/add_product.dart';
import 'app/favorites/favorites.dart';
import 'app/home/home.dart';
import 'app/product_details/product_details.dart';
import 'app/seller/seller.dart';
import 'app/seller_create/seller_create.dart';
import 'app/seller_products/seller_products.dart';
import 'app/shop/shop.dart';
import 'app/sign_in/sign_in.dart';
import 'app/sign_up/sign_up.dart';
import 'app/splash/splash.dart';

class AppRoutes {
  static const String addProduct = '/add-product';
  static const String favorites = '/favorites';
  static const String home = '/home';
  static const String product = '/product';
  static const String seller = '/seller';
  static const String sellerCreate = '/seller/create';
  static const String sellerProducts = '/seller/products';
  static const String shop = '/shop';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String splash = '/';

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  static final GoRouter routes = GoRouter(
    initialLocation: AppRoutes.splash,
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    observers: [routeObserver],
    routes: [
      GoRoute(
        path: '${AppRoutes.addProduct}/:sellerId',
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 100),
          reverseTransitionDuration: const Duration(milliseconds: 100),
          child: BlocProvider(
            create: (context) => AddProductBloc(
              addProductUseCase: AddProductUseCase(
                repository: SupabaseAddProductRepository(client: Supabase.instance.client),
              ),
            ),
            child: AddProductPage(sellerId: state.pathParameters['sellerId']!),
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
        path: '${AppRoutes.favorites}/:userId',
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 100),
          reverseTransitionDuration: const Duration(milliseconds: 100),
          child: BlocProvider(
            create: (context) => FavoritesBloc(
              fetchFavoritesProductListUseCase: FetchFavoritesProductListUseCase(
                repository: SupabaseFavoritesProductsRepository(client: Supabase.instance.client),
              ),
            ),
            child: FavoritesPage(userId: state.pathParameters['userId']!),
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
        path: AppRoutes.home,
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 100),
          reverseTransitionDuration: const Duration(milliseconds: 100),
          child: BlocProvider(
            create: (context) {
              final supabaseClient = Supabase.instance.client;
              return HomeBloc(
                fetchUserDetailsUseCase: FetchUserDetailsUseCase(
                  repository: SupabaseUserDetailsRepository(client: supabaseClient),
                ),
                fetchCategoryListUseCase: FetchCategoryListUseCase(
                  repository: SupabaseCategoryRepository(client: supabaseClient),
                ),
                fetchProductListUseCase: FetchProductListUseCase(
                  repository: SupabaseProductRepository(client: supabaseClient),
                ),
                fetchSellerListUseCase: FetchSellerListUseCase(
                  repository: SupabaseSellerRepository(client: supabaseClient),
                ),
                userSignOutUseCase: UserSignOutUseCase(
                  repository: SupabaseUserSignOutRepository(client: supabaseClient),
                ),
                verifyIfUserIsSellerUseCase: VerifyIfUserIsSellerUseCase(
                  repository: SupabaseUserDetailsRepository(client: supabaseClient),
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
          transitionDuration: const Duration(milliseconds: 100),
          reverseTransitionDuration: const Duration(milliseconds: 100),
          child: BlocProvider(
            create: (context) => ProductDetailsBloc(
              fetchProductDetailsUseCase: FetchProductDetailsUseCase(
                repository: SupabaseProductDetailsRepository(client: Supabase.instance.client),
              ),
              favoriteProductUseCase: FavoriteProductUseCase(
                repository: SupabaseProductDetailsRepository(client: Supabase.instance.client),
              ),
            ),
            child: ProductDetailsPage(
              userId: (state.extra as Map)['userId']!,
              productId: state.pathParameters['productId']!,
            ),
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
        path: '${AppRoutes.seller}/:sellerId',
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 100),
          reverseTransitionDuration: const Duration(milliseconds: 100),
          child: BlocProvider(
            create: (context) => SellerBloc(
              fetchSellerDetailsUseCase: FetchSellerDetailsUseCase(
                repository: SupabaseSellerDetailsRepository(client: Supabase.instance.client),
              ),
            ),
            child: SellerPage(sellerId: state.pathParameters['sellerId']!),
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
        path: '${AppRoutes.sellerCreate}/:userId',
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 100),
          reverseTransitionDuration: const Duration(milliseconds: 100),
          child: BlocProvider(
            create: (context) => SellerCreateBloc(
              sellerCreateUseCase: SellerCreateUseCase(
                repository: SupabaseSellerCreateRepository(client: Supabase.instance.client),
              ),
            ),
            child: SellerCreatePage(userId: state.pathParameters['userId']!),
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
        path: '${AppRoutes.sellerProducts}/:sellerId',
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 100),
          reverseTransitionDuration: const Duration(milliseconds: 100),
          child: BlocProvider(
            create: (context) => SellerProductsBloc(
              fetchSellerProductListUseCase: FetchSellerProductsListUseCase(
                repository: SupabaseSellerProductsRepository(client: Supabase.instance.client),
              ),
            ),
            child: SellerProductsPage(sellerId: state.pathParameters['sellerId']!),
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
        path: '${AppRoutes.shop}/:sellerId',
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 100),
          reverseTransitionDuration: const Duration(milliseconds: 100),
          child: BlocProvider(
            create: (context) => ShopBloc(
              fetchSellerDetailsUseCase: FetchShopDetailsUseCase(
                repository: SupabaseShopDetailsRepository(client: Supabase.instance.client),
              ),
              fetchSellerProductListUseCase: FetchShopProductListUseCase(
                repository: SupabaseShopProductRepository(client: Supabase.instance.client),
              ),
            ),
            child: ShopPage(sellerId: state.pathParameters['sellerId']!),
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
        path: AppRoutes.signIn,
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 100),
          reverseTransitionDuration: const Duration(milliseconds: 100),
          child: BlocProvider(
            create: (context) => SignInBloc(
              signInUseCase: SignInUseCase(
                repository: SupabaseSignInRepository(client: Supabase.instance.client),
              ),
            ),
            child: const SignInPage(),
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
        path: AppRoutes.signUp,
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 100),
          reverseTransitionDuration: const Duration(milliseconds: 100),
          child: BlocProvider(
            create: (context) => SignUpBloc(
              signUpUseCase: SignUpUseCase(
                repository: SupabaseSignUpRepository(client: Supabase.instance.client),
              ),
            ),
            child: const SignUpPage(),
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
        path: AppRoutes.splash,
        builder: (context, state) => BlocProvider(
          create: (context) => SplashBloc(),
          child: const SplashPage(),
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
