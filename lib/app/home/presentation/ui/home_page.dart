import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/extensions/extensions.dart';
import '../../../../shared/utils/utils.dart';
import '../../domain/entities/product_entity.dart';
import '../controller/home_bloc.dart';

class HomePage extends StatefulWidget {
  final UniqueKey? heroKey;

  const HomePage({super.key, this.heroKey});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc _bloc;

  late int _currentPageViewIndex;
  late final PageController _pageController;

  late int _currentCategoryIndex;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<HomeBloc>(context);
    _bloc.add(HomeStartedEvent());

    _currentPageViewIndex = 0;
    _pageController = PageController(initialPage: _currentPageViewIndex);

    _currentCategoryIndex = 0;
  }

  void _changePageView(int index) {
    setState(() {
      _currentPageViewIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomePageLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomePageLoadedState) {
            final categories = state.categories;
            final products = state.products;

            return Stack(
              children: [
                PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    RefreshIndicator(
                      onRefresh: () async {
                        _bloc.add(HomeStartedEvent());
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
                                SliverToBoxAdapter(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                                          child: Text(
                                            'Categorias',
                                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 36,
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            padding: const EdgeInsets.symmetric(horizontal: 24),
                                            physics: const BouncingScrollPhysics(),
                                            separatorBuilder: (context, index) => const SizedBox(width: 12),
                                            itemCount: categories.length + 1,
                                            itemBuilder: (context, index) {
                                              if (index == 0) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(24),
                                                    color: _currentCategoryIndex == index
                                                        ? Theme.of(context).colorScheme.primary
                                                        : Colors.transparent,
                                                    border: Border.all(
                                                      color: _currentCategoryIndex == index
                                                          ? Theme.of(context).colorScheme.primary
                                                          : Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                                                    ),
                                                  ),
                                                  padding: const EdgeInsets.symmetric(
                                                    vertical: 8,
                                                    horizontal: 16,
                                                  ),
                                                  child: Text(
                                                    'All categories',
                                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                          color: _currentCategoryIndex == index
                                                              ? Theme.of(context).colorScheme.onPrimary
                                                              : Theme.of(context)
                                                                  .colorScheme
                                                                  .onSurface
                                                                  .withOpacity(0.7),
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                );
                                              }

                                              return Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(24),
                                                  color: _currentCategoryIndex == index
                                                      ? Theme.of(context).colorScheme.primary
                                                      : Colors.transparent,
                                                  border: Border.all(
                                                    color: _currentCategoryIndex == index
                                                        ? Theme.of(context).colorScheme.primary
                                                        : Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                                                  ),
                                                ),
                                                padding: const EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal: 16,
                                                ),
                                                child: Text(
                                                  categories[index - 1].name.capitalize(),
                                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                        color: _currentCategoryIndex == index
                                                            ? Theme.of(context).colorScheme.onPrimary
                                                            : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SliverPadding(
                                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                                  sliver: MultiSliver(
                                    children: [
                                      SliverToBoxAdapter(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 24, 0, 16),
                                          child: Text(
                                            'Produtos',
                                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                ),
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
                                                            color: Theme.of(context)
                                                                .colorScheme
                                                                .onSurface
                                                                .withOpacity(0.5),
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
                    ),
                    CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverSafeArea(
                          top: true,
                          sliver: MultiSliver(
                            children: [
                              SliverToBoxAdapter(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                                        child: Text(
                                          'Sacola',
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
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
                    ),
                    CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverSafeArea(
                          top: true,
                          sliver: MultiSliver(
                            children: [
                              SliverToBoxAdapter(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                                        child: Text(
                                          'Perfil',
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
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
                    ),
                  ],
                ),
                SafeArea(
                  top: false,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(64),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface.withOpacity(.7),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(.05),
                            ),
                            borderRadius: BorderRadius.circular(64),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  _changePageView(0);
                                  _pageController.jumpToPage(0);
                                },
                                child: Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: _currentPageViewIndex == 0
                                        ? Theme.of(context).colorScheme.primary.withOpacity(.1)
                                        : Colors.transparent,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                    AppIcons.home,
                                    color: _currentPageViewIndex == 0
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              InkWell(
                                onTap: () {
                                  _changePageView(1);
                                  _pageController.jumpToPage(1);
                                },
                                child: Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: _currentPageViewIndex == 1
                                        ? Theme.of(context).colorScheme.primary.withOpacity(.1)
                                        : Colors.transparent,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                    AppIcons.shoppingBag,
                                    color: _currentPageViewIndex == 1
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              InkWell(
                                onTap: () {
                                  _changePageView(2);
                                  _pageController.jumpToPage(2);
                                },
                                child: Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: _currentPageViewIndex == 2
                                        ? Theme.of(context).colorScheme.primary.withOpacity(.1)
                                        : Colors.transparent,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                    AppIcons.profile,
                                    color: _currentPageViewIndex == 2
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
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
              ],
            );
          } else if (state is HomePageErrorState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Home Page Error',
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
              child: Text('Home Page Initial'),
            );
          }
        },
      ),
    );
  }
}

class OldProductItem extends StatelessWidget {
  final ProductEntity product;

  const OldProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade100,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product.name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
        ),
        Text(
          'R\$ ${product.price}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
