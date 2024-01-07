import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../app_routes.dart';
import '../controller/home_bloc.dart';

class ProductEntity {
  final List<String> photos;

  ProductEntity({required this.photos});
}

class HomePage extends StatefulWidget {
  final UniqueKey? heroKey;

  const HomePage({super.key, this.heroKey});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<HomeBloc>(context);
    _bloc.add(HomeStartedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomePageLoadedState) {
            context.go(AppRoutes.home);
          }
        },
        builder: (context, state) {
          if (state is HomePageLoadingState) {
            return const Center(
              child: Text('Home Page Loading'),
            );
          } else if (state is HomePageLoadedState) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SliverSafeArea(
                  top: false,
                  sliver: MultiSliver(
                    children: [
                      SliverToBoxAdapter(
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 16),
                          margin: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'iPhone 12 Pro Max',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Apple',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface,
                                      fontWeight: FontWeight.w400,
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
          } else if (state is HomePageErrorState) {
            return const Center(
              child: Text('Home Page Error'),
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
