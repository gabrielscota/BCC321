import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

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

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<SignInBloc>(context);

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInLoadingState) {
            showDialog(context: context, builder: (_) => const Center(child: CircularProgressIndicator()));
          } else if (state is SignInSuccessfullState) {
            if (context.canPop()) {
              Navigator.of(context).pop();
            }
            context.go(AppRoutes.home);
          } else if (state is SignInErrorState) {
            if (context.canPop()) {
              Navigator.of(context).pop();
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
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
                SliverSafeArea(
                  top: true,
                  sliver: MultiSliver(
                    children: [
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(24, 64, 24, 0),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Bem vindo!',
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onBackground,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Faça login para continuar',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
                        sliver: SliverToBoxAdapter(
                          child: TextField(
                            controller: _emailController,
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                              fillColor: Theme.of(context).colorScheme.onBackground.withOpacity(.05),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                        sliver: SliverToBoxAdapter(
                          child: TextField(
                            controller: _passwordController,
                            autocorrect: false,
                            keyboardType: TextInputType.visiblePassword,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                              fillColor: Theme.of(context).colorScheme.onBackground.withOpacity(.05),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                        sliver: SliverToBoxAdapter(
                          child: ElevatedButton(
                            onPressed: () {
                              _bloc.add(
                                SignInStartedEvent(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                            ),
                            child: Text(
                              'Entrar',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                        sliver: SliverToBoxAdapter(
                          child: TextButton(
                            onPressed: () {
                              context.go(AppRoutes.signUp);
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                            ),
                            child: Text(
                              'Não tem uma conta? Cadastre-se',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
