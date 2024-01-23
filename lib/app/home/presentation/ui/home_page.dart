import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../app_routes.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/extensions/extensions.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/widgets.dart';
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

  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<HomeBloc>(context);
    _bloc.add(HomeStartedEvent());

    _currentPageViewIndex = 0;
    _pageController = PageController(initialPage: _currentPageViewIndex);

    _currentCategoryIndex = 0;

    _searchController = TextEditingController();
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
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomePageLoadingState) {
            showDialog(context: context, builder: (_) => const Center(child: CircularProgressIndicator()));
          } else if (state is HomePageSignOutState) {
            if (context.canPop()) {
              Navigator.of(context).pop();
            }
            context.go(AppRoutes.signIn);
          } else if (state is HomePageErrorState) {
            if (context.canPop()) {
              Navigator.of(context).pop();
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          } else if (state is HomePageLoadedState) {
            if (context.canPop()) {
              Navigator.of(context).pop();
            }
          }
        },
        builder: (context, state) {
          if (state is HomePageLoadedState) {
            final user = state.user;
            final categories = state.categories;
            final products = state.products.where((product) {
              return product.name.toLowerCase().contains(_searchController.text.toLowerCase());
            }).toList(growable: true);
            final sellers = state.sellers;

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
                      edgeOffset: 32,
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
                                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                                  sliver: SliverToBoxAdapter(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Olá, ${user.name.split(' ').first} 👋',
                                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        Text(
                                          'O que você está procurando hoje?',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SliverPadding(
                                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                                  sliver: SliverToBoxAdapter(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        color: Theme.of(context).colorScheme.surface,
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          AppSvgIconComponent(
                                            assetName: AppIcons.search,
                                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: TextField(
                                              controller: _searchController,
                                              autocorrect: false,
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                              decoration: InputDecoration(
                                                hintText: 'Pesquisar',
                                                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                border: InputBorder.none,
                                              ),
                                              onChanged: (value) {
                                                setState(() {});
                                              },
                                              onTapOutside: (_) {
                                                FocusScope.of(context).unfocus();
                                              },
                                            ),
                                          ),
                                          Container(
                                            width: 1,
                                            height: 28,
                                            margin: const EdgeInsets.symmetric(horizontal: 12),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                left: BorderSide(
                                                  width: 1,
                                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                                                ),
                                              ),
                                            ),
                                          ),
                                          AppSvgIconComponent(
                                            assetName: AppIcons.filter,
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // MultiSliver(
                                //   children: [
                                //     SliverToBoxAdapter(
                                //       child: Padding(
                                //         padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
                                //         child: Text(
                                //           'Lojas',
                                //           style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                //                 color: Colors.black,
                                //                 fontWeight: FontWeight.w700,
                                //               ),
                                //         ),
                                //       ),
                                //     ),
                                //     SliverToBoxAdapter(
                                //       child: SizedBox(
                                //         height: 72,
                                //         child: ListView.separated(
                                //           scrollDirection: Axis.horizontal,
                                //           padding: const EdgeInsets.symmetric(horizontal: 24),
                                //           physics: const BouncingScrollPhysics(),
                                //           separatorBuilder: (context, index) => const SizedBox(width: 12),
                                //           itemCount: sellers.length,
                                //           itemBuilder: (context, index) {
                                //             return GestureDetector(
                                //               onTap: () {
                                //                 context.push(
                                //                   '${AppRoutes.shop}/${sellers[index].id}',
                                //                 );
                                //               },
                                //               child: Container(
                                //                 decoration: BoxDecoration(
                                //                   borderRadius: BorderRadius.circular(8),
                                //                   color: Colors.grey.shade100,
                                //                 ),
                                //                 padding: const EdgeInsets.all(16),
                                //                 child: Column(
                                //                   crossAxisAlignment: CrossAxisAlignment.start,
                                //                   children: [
                                //                     // Expanded(
                                //                     //   child: Container(
                                //                     //     decoration: BoxDecoration(
                                //                     //       borderRadius: BorderRadius.circular(8),
                                //                     //       color: Colors.grey.shade100,
                                //                     //     ),
                                //                     //   ),
                                //                     // ),
                                //                     // const SizedBox(height: 8),
                                //                     Text(
                                //                       sellers[index].shopName,
                                //                       style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                //                             color: Theme.of(context).colorScheme.onSurface,
                                //                             fontWeight: FontWeight.w500,
                                //                           ),
                                //                       maxLines: 1,
                                //                     ),
                                //                   ],
                                //                 ),
                                //               ),
                                //             );
                                //           },
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                SliverToBoxAdapter(
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(0, 24, 0, 16),
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
                                                    'Todas as categorias',
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
                                      SliverVisibility(
                                        visible: products.isNotEmpty,
                                        sliver: SliverAnimatedGrid(
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
                              SliverPadding(
                                padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                                sliver: SliverToBoxAdapter(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Meu carrinho',
                                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
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
                              SliverPadding(
                                padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
                                sliver: SliverToBoxAdapter(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Perfil',
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
                                padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                                sliver: SliverToBoxAdapter(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 64,
                                        width: 64,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(64),
                                          color: Colors.grey.shade100,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: user.photoUrl,
                                          height: 64,
                                          width: 64,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) => Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              user.name.length > 2
                                                  ? user.name.substring(0, 2).toUpperCase()
                                                  : user.name.substring(0, 1).toUpperCase(),
                                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                                    color: Theme.of(context).colorScheme.onSurface,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(16, 0, 24, 8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                user.name.split(' ').first,
                                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                                      color: Theme.of(context).colorScheme.onSurface,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                              ),
                                              Text(
                                                user.email,
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SliverPadding(
                                padding: const EdgeInsets.fromLTRB(0, 32, 0, 24),
                                sliver: SliverToBoxAdapter(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 24),
                                        child: Text(
                                          'CONTA',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                color: Theme.of(context).colorScheme.onSurface.withOpacity(.5),
                                                fontWeight: FontWeight.w700,
                                              ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const AppSvgIconComponent(
                                                assetName: AppIcons.profile,
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  'Informações pessoais',
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
                                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const AppSvgIconComponent(
                                                assetName: AppIcons.deliveryBox,
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  'Meus pedidos',
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
                                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const AppSvgIconComponent(
                                                assetName: AppIcons.heartLike,
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  'Favoritos',
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
                                          'VENDEDOR',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                color: Theme.of(context).colorScheme.onSurface.withOpacity(.5),
                                                fontWeight: FontWeight.w700,
                                              ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const AppSvgIconComponent(
                                                assetName: AppIcons.store,
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  'Minha loja',
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
                                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                                sliver: SliverToBoxAdapter(
                                  child: FilledButton(
                                    onPressed: () {
                                      _bloc.add(HomeSignOutEvent());
                                    },
                                    style: FilledButton.styleFrom(
                                      backgroundColor: Theme.of(context).colorScheme.onBackground,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 18),
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      'Sair',
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
                          child: Stack(
                            children: [
                              AnimatedAlign(
                                heightFactor: 1,
                                widthFactor: 3.5,
                                alignment: _currentPageViewIndex == 0
                                    ? Alignment.centerLeft
                                    : _currentPageViewIndex == 1
                                        ? Alignment.center
                                        : Alignment.centerRight,
                                duration: const Duration(milliseconds: 150),
                                curve: Curves.easeInOut,
                                child: Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: Theme.of(context).colorScheme.primary.withOpacity(.1),
                                  ),
                                ),
                              ),
                              Row(
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
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: AppSvgIconComponent(
                                        assetName: AppIcons.home,
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
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: AppSvgIconComponent(
                                        assetName: AppIcons.shoppingCart,
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
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: AppSvgIconComponent(
                                        assetName: AppIcons.profile,
                                        color: _currentPageViewIndex == 2
                                            ? Theme.of(context).colorScheme.primary
                                            : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ],
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
