import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app_routes.dart';
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
            context.go(AppRoutes.home);
          }
        },
        builder: (context, state) {
          if (state is SplashPageLoadingState) {
            return const Center(
              child: Text('Splash Page Loading'),
            );
          } else if (state is SplashPageLoadedState) {
            return const Center(
              child: Text('Splash Page Loaded'),
            );
          } else if (state is SplashPageErrorState) {
            return const Center(
              child: Text('Splash Page Error'),
            );
          } else {
            return const Center(
              child: Text('Splash Page Initial'),
            );
          }
        },
      ),
    );
  }
}
