import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/widgets.dart';
import '../controller/seller_products_bloc.dart';

class SellerProductsPage extends StatefulWidget {
  final UniqueKey? heroKey;
  final String sellerId;

  const SellerProductsPage({super.key, this.heroKey, required this.sellerId});

  @override
  State<SellerProductsPage> createState() => _SellerProductsPageState();
}

class _SellerProductsPageState extends State<SellerProductsPage> with RouteAware {
  late final SellerProductsBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<SellerProductsBloc>(context);
    _bloc.add(SellerProductsStartedEvent(sellerId: widget.sellerId));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppRoutes.routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    AppRoutes.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();

    _bloc.add(SellerProductsStartedEvent(sellerId: widget.sellerId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocConsumer<SellerProductsBloc, SellerProductsState>(
        listener: (context, state) {
          if (state is SellerProductsPageDeleteSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 2),
                content: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSvgIconComponent(
                      assetName: AppIcons.delete,
                      size: 28,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Produto excluído com sucesso!',
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
          }
        },
        builder: (context, state) {
          if (state is SellerProductsPageLoadingState) {
            return CustomScrollView(
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
                      const AppShimmerEffectComponent(),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is SellerProductsPageLoadedState) {
            final products = state.products;

            return CustomScrollView(
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
                        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppSvgIconComponent(
                                assetName: AppIcons.deliveryBoxes,
                                size: 48,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Meus produtos',
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverVisibility(
                        visible: products.isEmpty,
                        sliver: SliverToBoxAdapter(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 32),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const AppSvgIllustrationComponent(
                                  assetName: AppIllustrations.empty,
                                  fit: BoxFit.fitHeight,
                                  height: 200,
                                ),
                                const SizedBox(height: 32),
                                Text(
                                  'Oops, parece que você ainda não tem nenhum produto cadastrado..',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                                        fontWeight: FontWeight.w500,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverVisibility(
                        visible: products.isNotEmpty,
                        sliver: SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          sliver: SliverList.separated(
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            products[index].name,
                                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                                  color: Theme.of(context).colorScheme.onSurface,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                            maxLines: 2,
                                          ),
                                          Text(
                                            CurrencyFormat.formatCentsToReal(products[index].price),
                                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                  color: Theme.of(context).colorScheme.onSurface,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                            maxLines: 1,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            '${products[index].stockQuantity} em estoque',
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Row(
                                      children: [
                                        AppOutlinedSquaredIconButtonComponent(
                                          icon: AppIcons.edit,
                                          onPressed: () {
                                            context.push(
                                              AppRoutes.editProduct,
                                              extra: {
                                                'productId': products[index].id,
                                                'name': products[index].name,
                                                'description': products[index].description,
                                                'price': products[index].price,
                                                'stockQuantity': products[index].stockQuantity,
                                              },
                                            );
                                          },
                                        ),
                                        const SizedBox(width: 12),
                                        AppOutlinedSquaredIconButtonComponent(
                                          icon: AppIcons.delete,
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              backgroundColor: Theme.of(context).colorScheme.background,
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(24),
                                                  topRight: Radius.circular(24),
                                                ),
                                              ),
                                              useSafeArea: true,
                                              builder: (context) {
                                                return SafeArea(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            margin: const EdgeInsets.symmetric(vertical: 16),
                                                            height: 4,
                                                            width: 64,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(2),
                                                              color: Theme.of(context)
                                                                  .colorScheme
                                                                  .onSurface
                                                                  .withOpacity(.2),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                                                        child: Text(
                                                          'Apagar produto',
                                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.w700,
                                                              ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 24),
                                                        child: Text(
                                                          'Tem certeza que deseja apagar o produto? Essa ação não poderá ser desfeita.',
                                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                                color: Theme.of(context)
                                                                    .colorScheme
                                                                    .onSurface
                                                                    .withOpacity(.5),
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                          textAlign: TextAlign.start,
                                                          maxLines: 4,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(24, 32, 24, 12),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: OutlinedButton(
                                                                onPressed: () {
                                                                  context.pop();
                                                                },
                                                                style: OutlinedButton.styleFrom(
                                                                  foregroundColor:
                                                                      Theme.of(context).colorScheme.onSurface,
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(12),
                                                                  ),
                                                                  padding: const EdgeInsets.symmetric(vertical: 22),
                                                                  elevation: 0,
                                                                ),
                                                                child: Text(
                                                                  'Cancelar',
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyLarge
                                                                      ?.copyWith(
                                                                        color: Theme.of(context).colorScheme.onSurface,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(width: 16),
                                                            Expanded(
                                                              child: FilledButton(
                                                                onPressed: () {
                                                                  _bloc.add(
                                                                    SellerProductsDeleteProductEvent(
                                                                      productId: products[index].id,
                                                                    ),
                                                                  );
                                                                  context.pop();
                                                                },
                                                                style: FilledButton.styleFrom(
                                                                  backgroundColor: Theme.of(context).colorScheme.error,
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(12),
                                                                  ),
                                                                  padding: const EdgeInsets.symmetric(vertical: 22),
                                                                  elevation: 0,
                                                                ),
                                                                child: Text(
                                                                  'Apagar',
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyLarge
                                                                      ?.copyWith(
                                                                        color: Theme.of(context).colorScheme.onPrimary,
                                                                        fontWeight: FontWeight.w500,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => const SizedBox(height: 16),
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 32),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is SellerProductsPageErrorState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Seller Products Page Error',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.w500,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  state.message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('SellerProducts Page Initial'),
            );
          }
        },
      ),
    );
  }
}
