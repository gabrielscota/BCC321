import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/widgets.dart';
import '../controller/seller_bloc.dart';

class SellerPage extends StatefulWidget {
  final UniqueKey? heroKey;
  final String sellerId;

  const SellerPage({super.key, this.heroKey, required this.sellerId});

  @override
  State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  late final SellerBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<SellerBloc>(context);
    _bloc.add(SellerStartedEvent(sellerId: widget.sellerId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<SellerBloc, SellerState>(
        builder: (context, state) {
          if (state is SellerPageLoadingState) {
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
          } else if (state is SellerPageLoadedState) {
            final categories = state.categories;
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
                                'Scotá Shops 123',
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'São Paulo, SP',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface.withOpacity(.5),
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const SizedBox(height: 32),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Theme.of(context).colorScheme.onSurface.withOpacity(.07),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                child: Text(
                                  'MINHA LOJA',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Theme.of(context).colorScheme.onSurface.withOpacity(.5),
                                        fontWeight: FontWeight.w700,
                                      ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              const SizedBox(height: 12),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const AppSvgIconComponent(
                                        assetName: AppIcons.profile,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          'Informações da loja',
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      AppSvgIconComponent(
                                        assetName: AppIcons.arrowRight,
                                        color: Theme.of(context).colorScheme.onSurface.withOpacity(.7),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const AppSvgIconComponent(
                                        assetName: AppIcons.deliveryBox,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          'Pedidos',
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      AppSvgIconComponent(
                                        assetName: AppIcons.arrowRight,
                                        color: Theme.of(context).colorScheme.onSurface.withOpacity(.7),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 24),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Theme.of(context).colorScheme.onSurface.withOpacity(.07),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 24),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                child: Text(
                                  'PRODUTOS',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Theme.of(context).colorScheme.onSurface.withOpacity(.5),
                                        fontWeight: FontWeight.w700,
                                      ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              const SizedBox(height: 12),
                              InkWell(
                                onTap: () {
                                  context.push('${AppRoutes.addProduct}/${widget.sellerId}');
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const AppSvgIconComponent(
                                        assetName: AppIcons.deliveryBoxAdd,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          'Cadastrar produto',
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      AppSvgIconComponent(
                                        assetName: AppIcons.arrowRight,
                                        color: Theme.of(context).colorScheme.onSurface.withOpacity(.7),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.push('${AppRoutes.sellerProducts}/${widget.sellerId}');
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const AppSvgIconComponent(
                                        assetName: AppIcons.deliveryBoxes,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          'Meus produtos',
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                color: Theme.of(context).colorScheme.onSurface,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      AppSvgIconComponent(
                                        assetName: AppIcons.arrowRight,
                                        color: Theme.of(context).colorScheme.onSurface.withOpacity(.7),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is SellerPageErrorState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Seller Page Error',
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
              child: Text('Seller Page Initial'),
            );
          }
        },
      ),
    );
  }
}
