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
            return const Center(
              child: Text('ProductDetails Page Loading'),
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
                        ],
                      ),
                    ),
                  ],
                ),
                SafeArea(
                  top: false,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withOpacity(.6),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(.05),
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: SizedBox(
                            height: 64,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
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
                                  child: InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.horizontal(right: Radius.circular(16)),
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                      alignment: Alignment.center,
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
