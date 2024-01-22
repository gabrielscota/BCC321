import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/widgets.dart';
import '../controller/shop_bloc.dart';

class ShopPage extends StatefulWidget {
  final UniqueKey? heroKey;
  final String sellerId;

  const ShopPage({super.key, this.heroKey, required this.sellerId});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  late final ShopBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<ShopBloc>(context);
    _bloc.add(ShopStartedEvent(sellerId: widget.sellerId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          if (state is ShopPageLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ShopPageLoadedState) {
            final seller = state.seller;
            final products = state.products;

            return RefreshIndicator(
              onRefresh: () async {
                _bloc.add(ShopStartedEvent(sellerId: widget.sellerId));
              },
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  SliverSafeArea(
                    top: true,
                    sliver: MultiSliver(
                      children: [
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                          sliver: MultiSliver(
                            children: [
                              SliverPadding(
                                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
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
                                padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
                                sliver: SliverToBoxAdapter(
                                  child: Column(
                                    children: [
                                      Text(
                                        seller.shopName,
                                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                              color: Theme.of(context).colorScheme.onSurface,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        seller.description,
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
                              SliverAnimatedGrid(
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  // mainAxisExtent: 128,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  // childAspectRatio: 0.7,
                                ),
                                initialItemCount: products.length,
                                itemBuilder: (context, index, animation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: GestureDetector(
                                      onTap: () {
                                        context.push(
                                          '${AppRoutes.product}/${products[index].id}',
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: Colors.grey.shade100,
                                        ),
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Expanded(
                                            //   child: Container(
                                            //     decoration: BoxDecoration(
                                            //       borderRadius: BorderRadius.circular(8),
                                            //       color: Colors.grey.shade100,
                                            //     ),
                                            //   ),
                                            // ),
                                            // const SizedBox(height: 8),
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
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // child: OldProductItem(product: products[index]),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ShopPageErrorState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Shop Page Error',
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
              child: Text('Shop Page Initial'),
            );
          }
        },
      ),
    );
  }
}
