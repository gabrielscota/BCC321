import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/widgets.dart';
import '../controller/personal_information_bloc.dart';

class PersonalInformationPage extends StatefulWidget {
  final UniqueKey? heroKey;
  final Map product;

  const PersonalInformationPage({super.key, this.heroKey, required this.product});

  @override
  State<PersonalInformationPage> createState() => _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  late final PersonalInformationBloc _bloc;

  late final String _userId;

  late final bool _isPhysicalPerson = widget.product['isPhysicalPerson'];

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final MaskTextInputFormatter _phoneMaskFormatter;
  late final TextEditingController _cpfController;
  late final MaskTextInputFormatter _cpfMaskFormatter;
  late final TextEditingController _cnpjController;
  late final MaskTextInputFormatter _cnpjMaskFormatter;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<PersonalInformationBloc>(context);

    _userId = widget.product['userId'];

    _nameController = TextEditingController(text: widget.product['name']);
    _emailController = TextEditingController(text: widget.product['email']);
    _phoneMaskFormatter = MaskTextInputFormatter(mask: '(##) #####-####', filter: {'#': RegExp(r'[0-9]')});
    _phoneController = TextEditingController(text: _phoneMaskFormatter.maskText(widget.product['phone']));
    _cpfMaskFormatter = MaskTextInputFormatter(mask: '###.###.###-##', filter: {'#': RegExp(r'[0-9]')});
    _cpfController = TextEditingController(text: _cpfMaskFormatter.maskText(widget.product['cpf']));
    _cnpjMaskFormatter = MaskTextInputFormatter(mask: '##.###.###/####-##', filter: {'#': RegExp(r'[0-9]')});
    _cnpjController = TextEditingController(text: _cnpjMaskFormatter.maskText(widget.product['cnpj']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocConsumer<PersonalInformationBloc, PersonalInformationState>(
        listener: (context, state) {
          if (state is PersonalInformationLoadingState) {
            showDialog(context: context, builder: (_) => const Center(child: CircularProgressIndicator()));
          } else if (state is PersonalInformationSuccessfullState) {
            if (context.canPop()) {
              context.pop();
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(milliseconds: 1200),
                content: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppSvgIconComponent(
                      assetName: AppIcons.edit,
                      size: 28,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Informações atualizadas com sucesso!',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.surface,
                            ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Theme.of(context).colorScheme.onSurface,
                padding: const EdgeInsets.fromLTRB(32, 24, 32, 48),
              ),
            );
          } else if (state is PersonalInformationErrorState) {
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
          return Column(
            children: [
              Expanded(
                child: CustomScrollView(
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
                                    assetName: AppIcons.profile,
                                    size: 48,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Informações pessoais',
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
                                  enabled: false,
                                  readOnly: true,
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
                                    suffixIconConstraints: const BoxConstraints(maxHeight: 64, maxWidth: 64),
                                    suffixIcon: const Padding(
                                      padding: EdgeInsets.only(right: 16),
                                      child: AppSvgIconComponent(assetName: AppIcons.lock),
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
                                  enabled: false,
                                  readOnly: true,
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
                                    suffixIconConstraints: const BoxConstraints(maxHeight: 64, maxWidth: 64),
                                    suffixIcon: const Padding(
                                      padding: EdgeInsets.only(right: 16),
                                      child: AppSvgIconComponent(assetName: AppIcons.lock),
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
                                enabled: false,
                                readOnly: true,
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
                                  suffixIconConstraints: const BoxConstraints(maxHeight: 64, maxWidth: 64),
                                  suffixIcon: const Padding(
                                    padding: EdgeInsets.only(right: 16),
                                    child: AppSvgIconComponent(assetName: AppIcons.lock),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          _bloc.add(
                            PersonalInformationStartedEvent(
                              userId: _userId,
                              name: _nameController.text,
                              phone: _phoneController.text,
                            ),
                          );
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.onBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 22),
                          elevation: 0,
                        ),
                        child: Text(
                          'Atualizar informações',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
