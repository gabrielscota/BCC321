import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/widgets.dart';
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
  late final TextEditingController _cnpjController;
  late final MaskTextInputFormatter _cnpjMaskFormatter;
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
    _cnpjController = TextEditingController();
    _cnpjMaskFormatter = MaskTextInputFormatter(mask: '##.###.###/####-##', filter: {'#': RegExp(r'[0-9]')});
    _passwordController = TextEditingController();
  }

  bool _obscureText = true;
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool _isPhysicalPerson = true;
  void _toggleIsPhysicalPerson() {
    setState(() {
      _isPhysicalPerson = !_isPhysicalPerson;
    });
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
              context.pop();
            }
            context.go(AppRoutes.home);
          } else if (state is SignUpErrorState) {
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
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverSafeArea(
                top: true,
                sliver: MultiSliver(
                  children: [
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          children: [
                            AppOutlinedSquaredIconButtonComponent(
                              icon: AppIcons.arrowLeft,
                              onPressed: () => context.pop(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppSvgIconComponent(
                              assetName: AppIcons.addUser,
                              size: 48,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Crie sua conta',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          height: 64,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onBackground.withOpacity(.05),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: LayoutBuilder(builder: (context, constraints) {
                            return Stack(
                              children: [
                                AnimatedAlign(
                                  alignment: _isPhysicalPerson ? Alignment.centerLeft : Alignment.centerRight,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeInOut,
                                  child: Container(
                                    width: constraints.maxWidth / 2,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.onBackground,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: _toggleIsPhysicalPerson,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            AppSvgIconComponent(
                                              assetName: AppIcons.userInformation,
                                              color: _isPhysicalPerson
                                                  ? Theme.of(context).colorScheme.onPrimary
                                                  : Theme.of(context).colorScheme.onBackground.withOpacity(.5),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Pessoa física',
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    color: _isPhysicalPerson
                                                        ? Theme.of(context).colorScheme.onPrimary
                                                        : Theme.of(context).colorScheme.onBackground.withOpacity(.5),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: _toggleIsPhysicalPerson,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            AppSvgIconComponent(
                                              assetName: AppIcons.buildingOffice,
                                              color: !_isPhysicalPerson
                                                  ? Theme.of(context).colorScheme.onPrimary
                                                  : Theme.of(context).colorScheme.onBackground.withOpacity(.5),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Pessoa jurídica',
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    color: !_isPhysicalPerson
                                                        ? Theme.of(context).colorScheme.onPrimary
                                                        : Theme.of(context).colorScheme.onBackground.withOpacity(.5),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                      sliver: SliverToBoxAdapter(
                        child: TextField(
                          controller: _nameController,
                          cursorHeight: 24,
                          textAlign: TextAlign.start,
                          autocorrect: true,
                          enableSuggestions: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                          decoration: InputDecoration(
                            hintText: 'Nome',
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
                                assetName: AppIcons.profile,
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
                    SliverVisibility(
                      visible: _isPhysicalPerson,
                      sliver: SliverPadding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                        sliver: SliverToBoxAdapter(
                          child: TextField(
                            controller: _cpfController,
                            cursorHeight: 24,
                            textAlign: TextAlign.start,
                            autocorrect: false,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                            decoration: InputDecoration(
                              hintText: 'CPF',
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
                                  assetName: AppIcons.userInformation,
                                  size: 28,
                                  color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
                                ),
                              ),
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            onTapOutside: (_) => FocusScope.of(context).unfocus(),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              _cpfMaskFormatter,
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverVisibility(
                      visible: !_isPhysicalPerson,
                      sliver: SliverPadding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                        sliver: SliverToBoxAdapter(
                          child: TextField(
                            controller: _cnpjController,
                            cursorHeight: 24,
                            textAlign: TextAlign.start,
                            autocorrect: false,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                            decoration: InputDecoration(
                              hintText: 'CNPJ',
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
                                  assetName: AppIcons.buildingOffice,
                                  size: 28,
                                  color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
                                ),
                              ),
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            onTapOutside: (_) => FocusScope.of(context).unfocus(),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              _cnpjMaskFormatter,
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
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
                          controller: _phoneController,
                          cursorHeight: 24,
                          textAlign: TextAlign.start,
                          autocorrect: false,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context).colorScheme.onBackground,
                              ),
                          decoration: InputDecoration(
                            hintText: 'Telefone',
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
                                assetName: AppIcons.call,
                                size: 28,
                                color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
                              ),
                            ),
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
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
                          controller: _passwordController,
                          cursorHeight: 24,
                          textAlign: TextAlign.start,
                          autocorrect: false,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
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
                              SignUpStartedEvent(
                                name: _nameController.text,
                                email: _emailController.text,
                                phone: _phoneController.text,
                                password: _passwordController.text,
                                isPhysicalPerson: _isPhysicalPerson,
                                cpf: _cpfController.text,
                                cnpj: _cnpjController.text,
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
                            'Cadastrar',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.w500,
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
