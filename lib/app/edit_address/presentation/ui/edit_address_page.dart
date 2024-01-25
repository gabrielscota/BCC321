import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/widgets.dart';
import '../controller/edit_address_bloc.dart';

class EditAddressPage extends StatefulWidget {
  final UniqueKey? heroKey;
  final Map product;

  const EditAddressPage({super.key, this.heroKey, required this.product});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  late final EditAddressBloc _bloc;

  late final String _addressId;

  late final TextEditingController _zipCodeController;
  late final MaskTextInputFormatter _zipCodeFormatter;
  late final TextEditingController _streetController;
  late final TextEditingController _numberController;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  late final TextEditingController _countryController;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<EditAddressBloc>(context);

    _addressId = widget.product['addressId'];

    _zipCodeFormatter = MaskTextInputFormatter(mask: '#####-###', filter: {'#': RegExp(r'[0-9]')});
    _zipCodeController = TextEditingController(text: _zipCodeFormatter.maskText(widget.product['zipCode']));
    _streetController = TextEditingController(text: widget.product['street']);
    _numberController = TextEditingController(text: widget.product['number']);
    _cityController = TextEditingController(text: widget.product['city']);
    _stateController = TextEditingController(text: widget.product['state']);
    _countryController = TextEditingController(text: widget.product['country']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocConsumer<EditAddressBloc, EditAddressState>(
        listener: (context, state) {
          if (state is EditAddressLoadingState) {
            showDialog(context: context, builder: (_) => const Center(child: CircularProgressIndicator()));
          } else if (state is EditAddressSuccessfullState) {
            if (context.canPop()) {
              context.pop();
              context.pop();
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(milliseconds: 1200),
                content: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSvgIconComponent(
                      assetName: AppIcons.location,
                      size: 28,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Endereço editado com sucesso!',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                    ),
                  ],
                ),
                backgroundColor: Theme.of(context).colorScheme.onSurface,
                padding: const EdgeInsets.fromLTRB(32, 24, 32, 48),
              ),
            );
          } else if (state is EditAddressErrorState) {
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
                                    assetName: AppIcons.location,
                                    size: 48,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Editar endereço',
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
                              child: TextField(
                                controller: _zipCodeController,
                                cursorHeight: 24,
                                textAlign: TextAlign.start,
                                autocorrect: true,
                                keyboardType: TextInputType.number,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.onBackground,
                                    ),
                                decoration: InputDecoration(
                                  hintText: 'CEP',
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
                                ),
                                textAlignVertical: TextAlignVertical.center,
                                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  _zipCodeFormatter,
                                ],
                              ),
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                            sliver: SliverToBoxAdapter(
                              child: TextField(
                                controller: _streetController,
                                cursorHeight: 24,
                                textAlign: TextAlign.start,
                                autocorrect: true,
                                keyboardType: TextInputType.text,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.onBackground,
                                    ),
                                decoration: InputDecoration(
                                  hintText: 'Rua',
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
                                controller: _numberController,
                                cursorHeight: 24,
                                textAlign: TextAlign.start,
                                autocorrect: true,
                                keyboardType: TextInputType.text,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.onBackground,
                                    ),
                                decoration: InputDecoration(
                                  hintText: 'Número',
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
                                controller: _cityController,
                                cursorHeight: 24,
                                textAlign: TextAlign.start,
                                autocorrect: true,
                                keyboardType: TextInputType.text,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.onBackground,
                                    ),
                                decoration: InputDecoration(
                                  hintText: 'Cidade',
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
                                controller: _stateController,
                                cursorHeight: 24,
                                textAlign: TextAlign.start,
                                autocorrect: true,
                                keyboardType: TextInputType.text,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.onBackground,
                                    ),
                                decoration: InputDecoration(
                                  hintText: 'Estado',
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
                                controller: _countryController,
                                cursorHeight: 24,
                                textAlign: TextAlign.start,
                                autocorrect: true,
                                keyboardType: TextInputType.text,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.onBackground,
                                    ),
                                decoration: InputDecoration(
                                  hintText: 'País',
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
                                ),
                                textAlignVertical: TextAlignVertical.center,
                                onTapOutside: (_) => FocusScope.of(context).unfocus(),
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
                            EditAddressStartedEvent(
                              addressId: _addressId,
                              street: _streetController.text,
                              number: _numberController.text,
                              city: _cityController.text,
                              state: _stateController.text,
                              country: _countryController.text,
                              zipCode: _zipCodeController.text,
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
                          'Salvar',
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
