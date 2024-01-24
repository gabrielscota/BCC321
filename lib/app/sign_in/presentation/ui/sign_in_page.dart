import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/widgets.dart';
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

  bool _obscureText = true;
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
              context.pop();
            }
            context.go(AppRoutes.home);
          } else if (state is SignInErrorState) {
            if (context.canPop()) {
              context.pop();
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverSafeArea(
                top: true,
                sliver: MultiSliver(
                  children: [
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 72, 24, 32),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                              'Faça o login para continuar',
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
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                      sliver: SliverToBoxAdapter(
                        child: TextField(
                          controller: _emailController,
                          cursorHeight: 24,
                          textAlign: TextAlign.start,
                          autocorrect: true,
                          enableSuggestions: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Theme.of(context).colorScheme.onBackground.withOpacity(.05),
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
                            alignLabelWithHint: true,
                            isDense: true,
                            prefixIconConstraints: const BoxConstraints(maxWidth: 56),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 16, right: 12),
                              child: AppSvgIconComponent(
                                assetName: AppIcons.mention,
                                size: 28,
                                color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
                              ),
                            ),
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                      sliver: SliverToBoxAdapter(
                        child: TextField(
                          controller: _passwordController,
                          cursorHeight: 24,
                          textAlign: TextAlign.start,
                          autocorrect: false,
                          keyboardType: TextInputType.visiblePassword,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                          decoration: InputDecoration(
                            hintText: 'Senha',
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Theme.of(context).colorScheme.onBackground.withOpacity(.05),
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
                            alignLabelWithHint: true,
                            isDense: true,
                            prefixIconConstraints: const BoxConstraints(maxWidth: 56),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 16, right: 12),
                              child: AppSvgIconComponent(
                                assetName: AppIcons.key,
                                size: 28,
                                color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
                              ),
                            ),
                            suffixIconConstraints: const BoxConstraints(maxWidth: 64, maxHeight: 64),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
                              child: InkWell(
                                onTap: _toggleObscureText,
                                borderRadius: BorderRadius.circular(32),
                                child: AppSvgIconComponent(
                                  assetName: _obscureText ? AppIcons.eye : AppIcons.eyeOff,
                                  size: 32,
                                  color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
                                ),
                              ),
                            ),
                          ),
                          obscureText: _obscureText,
                          textAlignVertical: TextAlignVertical.center,
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                      sliver: SliverToBoxAdapter(
                        child: FilledButton(
                          onPressed: () {
                            _bloc.add(
                              SignInStartedEvent(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 22),
                            elevation: 0,
                          ),
                          child: Text(
                            'Entrar',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.w500,
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
                            context.push(AppRoutes.signUp);
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                          ),
                          child: Text.rich(
                            TextSpan(
                              text: 'Não tem uma conta? ',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
                                  ),
                              children: [
                                TextSpan(
                                  text: 'Cadastre-se',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: Theme.of(context).colorScheme.primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
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
        },
      ),
    );
  }
}
