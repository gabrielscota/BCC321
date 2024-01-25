import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/widgets.dart';
import '../controller/seller_create_bloc.dart';

class SellerCreatePage extends StatefulWidget {
  final UniqueKey? heroKey;
  final String userId;

  const SellerCreatePage({super.key, this.heroKey, required this.userId});

  @override
  State<SellerCreatePage> createState() => _SellerCreatePageState();
}

class _SellerCreatePageState extends State<SellerCreatePage> {
  late final SellerCreateBloc _bloc;

  late final TextEditingController _shopNameController;
  late final TextEditingController _shopDescriptionController;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<SellerCreateBloc>(context);

    _shopNameController = TextEditingController();
    _shopDescriptionController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocConsumer<SellerCreateBloc, SellerCreateState>(
        listener: (context, state) {
          if (state is SellerCreateLoadingState) {
            showDialog(context: context, builder: (_) => const Center(child: CircularProgressIndicator()));
          } else if (state is SellerCreateSuccessfullState) {
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
                      assetName: AppIcons.buildingOffice,
                      size: 28,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Loja criada com sucesso!',
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
          } else if (state is SellerCreateErrorState) {
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
                              assetName: AppIcons.buildingOffice,
                              size: 48,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Crie sua loja',
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
                          controller: _shopNameController,
                          cursorHeight: 24,
                          textAlign: TextAlign.start,
                          autocorrect: true,
                          keyboardType: TextInputType.text,
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
                          controller: _shopDescriptionController,
                          cursorHeight: 24,
                          textAlign: TextAlign.start,
                          autocorrect: true,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
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
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                          maxLines: 3,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                      sliver: SliverToBoxAdapter(
                        child: FilledButton(
                          onPressed: () {
                            _bloc.add(
                              SellerCreateStartedEvent(
                                shopName: _shopNameController.text,
                                shopDescription: _shopDescriptionController.text,
                                userId: widget.userId,
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
                            'Criar loja',
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
