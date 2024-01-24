import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/widgets.dart';
import '../controller/product_details_bloc.dart';

class ProductDetailsPage extends StatefulWidget {
  final UniqueKey? heroKey;
  final String productId;

  const ProductDetailsPage({super.key, this.heroKey, required this.productId});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late final ProductDetailsBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<ProductDetailsBloc>(context);
    _bloc.add(ProductDetailsStartedEvent(productId: widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsPageLoadingState) {
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
          } else if (state is ProductDetailsPageLoadedState) {
            return Stack(
              children: [
                CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverSafeArea(
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
                          const SliverPadding(
                            padding: EdgeInsets.all(24),
                            sliver: SliverToBoxAdapter(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Placeholder(),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 24),
                              margin: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.product.name,
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                  // const SizedBox(height: 4),
                                  // Text(
                                  //   state.product.description,
                                  //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  //         color: Theme.of(context).colorScheme.onSurface.withOpacity(.6),
                                  //         fontWeight: FontWeight.w400,
                                  //       ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                                  child: Text(
                                    'Descrição do produto',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                                  child: Text(
                                    state.product.description,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: Theme.of(context).colorScheme.onSurface.withOpacity(.6),
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                            sliver: SliverToBoxAdapter(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(.05),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    const TextSpan(
                                                      text: '4.6',
                                                    ),
                                                    TextSpan(
                                                      text: ' /5',
                                                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                                            color: Theme.of(context).colorScheme.onSurface,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                                      color: Theme.of(context).colorScheme.onSurface,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'Baseado em 100 avaliações',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(.6),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                          ),
                                          const SizedBox(height: 12),
                                          const Row(
                                            children: [
                                              AppSvgIconComponent(assetName: AppIcons.star),
                                              AppSvgIconComponent(assetName: AppIcons.star),
                                              AppSvgIconComponent(assetName: AppIcons.star),
                                              AppSvgIconComponent(assetName: AppIcons.star),
                                              AppSvgIconComponent(assetName: AppIcons.star),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                '5 Estrela',
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                      color: Theme.of(context).colorScheme.onSurface.withOpacity(.6),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                              ),
                                              const SizedBox(width: 12),
                                              SizedBox(
                                                height: 8,
                                                width: 64,
                                                child: LinearProgressIndicator(
                                                  value: .8,
                                                  borderRadius: BorderRadius.circular(10),
                                                  backgroundColor:
                                                      Theme.of(context).colorScheme.onSurface.withOpacity(.1),
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                '4 Estrela',
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                      color: Theme.of(context).colorScheme.onSurface.withOpacity(.6),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                              ),
                                              const SizedBox(width: 12),
                                              SizedBox(
                                                height: 8,
                                                width: 64,
                                                child: LinearProgressIndicator(
                                                  value: .8,
                                                  borderRadius: BorderRadius.circular(10),
                                                  backgroundColor:
                                                      Theme.of(context).colorScheme.onSurface.withOpacity(.1),
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                '3 Estrela',
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                      color: Theme.of(context).colorScheme.onSurface.withOpacity(.6),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                              ),
                                              const SizedBox(width: 12),
                                              SizedBox(
                                                height: 8,
                                                width: 64,
                                                child: LinearProgressIndicator(
                                                  value: .8,
                                                  borderRadius: BorderRadius.circular(10),
                                                  backgroundColor:
                                                      Theme.of(context).colorScheme.onSurface.withOpacity(.1),
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                '2 Estrela',
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                      color: Theme.of(context).colorScheme.onSurface.withOpacity(.6),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                              ),
                                              const SizedBox(width: 12),
                                              SizedBox(
                                                height: 8,
                                                width: 64,
                                                child: LinearProgressIndicator(
                                                  value: .8,
                                                  borderRadius: BorderRadius.circular(10),
                                                  backgroundColor:
                                                      Theme.of(context).colorScheme.onSurface.withOpacity(.1),
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                '1 Estrela',
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                      color: Theme.of(context).colorScheme.onSurface.withOpacity(.6),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                              ),
                                              const SizedBox(width: 12),
                                              SizedBox(
                                                height: 8,
                                                width: 64,
                                                child: LinearProgressIndicator(
                                                  value: .8,
                                                  borderRadius: BorderRadius.circular(10),
                                                  backgroundColor:
                                                      Theme.of(context).colorScheme.onSurface.withOpacity(.1),
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(height: 128),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: Container(
                            height: 72,
                            margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.primary.withOpacity(.6),
                                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                                    ),
                                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          CurrencyFormat.formatCentsToReal(state.product.price),
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                color: Theme.of(context).colorScheme.onPrimary,
                                                fontWeight: FontWeight.w700,
                                              ),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          'Preço por unidade',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                color: Theme.of(context).colorScheme.onPrimary.withOpacity(.6),
                                                fontWeight: FontWeight.w400,
                                              ),
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: FilledButton(
                                    onPressed: () {},
                                    style: FilledButton.styleFrom(
                                      backgroundColor: Theme.of(context).colorScheme.primary,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
                                      ),
                                      elevation: 0,
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Text(
                                      'Comprar',
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            color: Theme.of(context).colorScheme.onPrimary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is ProductDetailsPageErrorState) {
            return const Center(
              child: Text('ProductDetails Page Error'),
            );
          } else {
            return const Center(
              child: Text('ProductDetails Page Initial'),
            );
          }
        },
      ),
    );
  }
}
