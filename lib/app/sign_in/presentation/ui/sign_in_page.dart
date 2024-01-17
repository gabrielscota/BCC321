import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app_routes.dart';
import '../controller/sign_in_bloc.dart';

class SignInPage extends StatefulWidget {
  final UniqueKey? heroKey;

  const SignInPage({super.key, this.heroKey});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final SignInBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<SignInBloc>(context);
    // _bloc.add(HomeStartedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccessfullState) {
            context.go(AppRoutes.home);
          }
        },
        builder: (context, state) {
          if (state is SignInLoadingState) {
            return const Center(
              child: Text('Splash Page Loading'),
            );
          } else {
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          'Sign In',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            _bloc.add(SignInStartedEvent(email: 'gabrielscota2015@gmail.com', password: '123456'));
                          },
                          child: const Text('Sign In'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
