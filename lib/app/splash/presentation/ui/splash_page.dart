import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../controller/splash_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final SplashBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<SplashBloc>(context);
    _bloc.add(SplashStartedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashPageLoadedState) {
            if (state.currentSession.isNotEmpty) {
              context.go(AppRoutes.home);
            } else {
              context.go(AppRoutes.signIn);
            }
          }
        },
        builder: (context, state) {
          return Center(
            child: Lottie.asset(
              AppAnimations.loadingWhite,
              width: 64,
              height: 64,
              alignment: Alignment.center,
            ),
          );
        },
      ),
    );
  }
}
