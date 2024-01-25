import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/widgets.dart';
import '../controller/shop_information_bloc.dart';

class ShopInformationPage extends StatefulWidget {
  final UniqueKey? heroKey;
  final Map shop;

  const ShopInformationPage({super.key, this.heroKey, required this.shop});

  @override
  State<ShopInformationPage> createState() => _ShopInformationPageState();
}

class _ShopInformationPageState extends State<ShopInformationPage> {
  late final ShopInformationBloc _bloc;

  late final String _sellerId;

  late final TextEditingController _shopNameController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<ShopInformationBloc>(context);

    _sellerId = widget.shop['sellerId'];

    _shopNameController = TextEditingController(text: widget.shop['shopName']);
    _descriptionController = TextEditingController(text: widget.shop['description']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocConsumer<ShopInformationBloc, ShopInformationState>(
        listener: (context, state) {
          if (state is ShopInformationLoadingState) {
            showDialog(context: context, builder: (_) => const Center(child: CircularProgressIndicator()));
          } else if (state is ShopInformationSuccessfullState) {
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
          } else if (state is ShopInformationErrorState) {
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
                                    assetName: AppIcons.store,
                                    size: 48,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Informações da loja',
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
                                controller: _shopNameController,
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
                                  hintText: 'Nome da loja',
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
                              ),
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                            sliver: SliverToBoxAdapter(
                              child: TextField(
                                controller: _descriptionController,
                                cursorHeight: 24,
                                textAlign: TextAlign.start,
                                autocorrect: true,
                                enableSuggestions: true,
                                textInputAction: TextInputAction.done,
                                textCapitalization: TextCapitalization.sentences,
                                keyboardType: TextInputType.text,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.onBackground,
                                    ),
                                decoration: InputDecoration(
                                  hintText: 'Descrição (opcional)',
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
                                      assetName: AppIcons.documentBadge,
                                      size: 28,
                                      color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
                                    ),
                                  ),
                                ),
                                textAlignVertical: TextAlignVertical.center,
                                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                                maxLines: 3,
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
                            ShopInformationStartedEvent(
                              sellerId: _sellerId,
                              shopName: _shopNameController.text,
                              description: _descriptionController.text,
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
