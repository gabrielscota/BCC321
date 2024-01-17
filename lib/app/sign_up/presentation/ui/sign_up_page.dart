import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app_routes.dart';
import '../controller/sign_up_bloc.dart';

class SignUpPage extends StatefulWidget {
  final UniqueKey? heroKey;

  const SignUpPage({super.key, this.heroKey});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final SignUpBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<SignUpBloc>(context);
    // _bloc.add(HomeStartedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccessfullState) {
            context.go(AppRoutes.home);
          }
        },
        builder: (context, state) {
          if (state is SignUpLoadingState) {
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
                            _bloc.add(SignUpStartedEvent(email: 'gabrielscota2015@gmail.com', password: '123456'));
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
