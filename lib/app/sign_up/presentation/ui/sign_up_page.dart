import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sliver_tools/sliver_tools.dart';

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

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final MaskTextInputFormatter _phoneMaskFormatter;
  late final TextEditingController _cpfController;
  late final MaskTextInputFormatter _cpfMaskFormatter;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<SignUpBloc>(context);

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _phoneMaskFormatter = MaskTextInputFormatter(mask: '(##) #####-####', filter: {'#': RegExp(r'[0-9]')});
    _cpfController = TextEditingController();
    _cpfMaskFormatter = MaskTextInputFormatter(mask: '###.###.###-##', filter: {'#': RegExp(r'[0-9]')});
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpLoadingState) {
            showDialog(context: context, builder: (_) => const Center(child: CircularProgressIndicator()));
          } else if (state is SignUpSuccessfullState) {
            if (context.canPop()) {
              Navigator.of(context).pop();
            }
            context.go(AppRoutes.home);
          } else if (state is SignUpErrorState) {
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
          if (state is SignUpLoadingState) {
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
                                'Crie sua conta para começar a usar o app',
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
                            controller: _nameController,
                            autocorrect: false,
                            keyboardType: TextInputType.name,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                            decoration: InputDecoration(
                              labelText: 'Nome',
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
                            controller: _phoneController,
                            autocorrect: false,
                            keyboardType: TextInputType.phone,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                            decoration: InputDecoration(
                              labelText: 'Telefone',
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
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              _phoneMaskFormatter,
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                        sliver: SliverToBoxAdapter(
                          child: TextField(
                            controller: _cpfController,
                            autocorrect: false,
                            keyboardType: TextInputType.number,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                            decoration: InputDecoration(
                              labelText: 'CPF',
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
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              _cpfMaskFormatter,
                            ],
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
                                SignUpStartedEvent(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  phone: _phoneController.text,
                                  cpf: _cpfController.text,
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
                              'Criar conta',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context).colorScheme.onPrimary,
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
