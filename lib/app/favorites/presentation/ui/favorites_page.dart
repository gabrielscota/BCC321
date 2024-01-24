import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/widgets.dart';
import '../controller/favorites_bloc.dart';

class FavoritesPage extends StatefulWidget {
  final UniqueKey? heroKey;
  final String userId;

  const FavoritesPage({super.key, this.heroKey, required this.userId});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> with RouteAware {
  late final FavoritesBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<FavoritesBloc>(context);
    _bloc.add(FavoritesStartedEvent(userId: widget.userId));
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

    _bloc.add(FavoritesStartedEvent(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesPageLoadingState) {
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
          } else if (state is FavoritesPageLoadedState) {
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
                                assetName: AppIcons.heart,
                                size: 48,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Produtos favoritos',
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
                                  'Oops, parece que você ainda não favoritou nenhum produto.',
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
                          sliver: SliverGrid.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.74,
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 24,
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  context.push(
                                    '${AppRoutes.product}/${products[index].id}',
                                    extra: {
                                      'userId': widget.userId,
                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(.03),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 1,
                                        child: Hero(
                                          tag: 'product-${products[index].id}',
                                          child: const AppSvgIconComponent(
                                            assetName: AppIcons.deliveryBox,
                                            size: 32,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        products[index].name,
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                              color: Theme.of(context).colorScheme.onSurface,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        CurrencyFormat.formatCentsToReal(products[index].price),
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                              color: Theme.of(context).colorScheme.onSurface.withOpacity(.5),
                                              fontWeight: FontWeight.w500,
                                            ),
                                        maxLines: 1,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
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
          } else if (state is FavoritesPageErrorState) {
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
              child: Text('Favorites Page Initial'),
            );
          }
        },
      ),
    );
  }
}
