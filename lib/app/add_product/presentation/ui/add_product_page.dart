import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/widgets.dart';
import '../controller/add_product_bloc.dart';

class AddProductPage extends StatefulWidget {
  final UniqueKey? heroKey;
  final String sellerId;

  const AddProductPage({super.key, this.heroKey, required this.sellerId});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  late final AddProductBloc _bloc;

  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priceController;
  late final TextEditingController _stockQuantityController;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<AddProductBloc>(context);
    _bloc.add(AddProductLoadCategoriesEvent());

    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
    _stockQuantityController = TextEditingController();
  }

  String _categoryId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocConsumer<AddProductBloc, AddProductState>(
        listener: (context, state) {
          if (state is AddProductLoadingState) {
            showDialog(context: context, builder: (_) => const Center(child: CircularProgressIndicator()));
          } else if (state is AddProductSuccessfullState) {
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
                      assetName: AppIcons.deliveryBoxAdd,
                      size: 28,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Produto cadastrado com sucesso!',
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
          } else if (state is AddProductErrorState) {
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
          if (state is AddProductLoadedState) {
            final categories = state.categories;
            if (_categoryId.isEmpty) {
              _categoryId = categories.last.id;
            }

            return Column(
              children: [
                Expanded(
                  child: CustomScrollView(
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
                                      assetName: AppIcons.deliveryBoxAdd,
                                      size: 48,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Novo produto',
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
                                  controller: _nameController,
                                  cursorHeight: 24,
                                  textAlign: TextAlign.start,
                                  autocorrect: true,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: Theme.of(context).colorScheme.onBackground,
                                      ),
                                  decoration: InputDecoration(
                                    hintText: 'Nome do produto',
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
                                  controller: _descriptionController,
                                  cursorHeight: 24,
                                  textAlign: TextAlign.start,
                                  autocorrect: true,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
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
                                  maxLines: 2,
                                ),
                              ),
                            ),
                            SliverPadding(
                              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                              sliver: SliverToBoxAdapter(
                                child: TextField(
                                  controller: _priceController,
                                  cursorHeight: 24,
                                  textAlign: TextAlign.start,
                                  autocorrect: true,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: Theme.of(context).colorScheme.onBackground,
                                      ),
                                  decoration: InputDecoration(
                                    hintText: 'Preço',
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
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    AppMoneyTextInputFormatter(),
                                  ],
                                ),
                              ),
                            ),
                            SliverPadding(
                              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                              sliver: SliverToBoxAdapter(
                                child: TextField(
                                  controller: _stockQuantityController,
                                  cursorHeight: 24,
                                  textAlign: TextAlign.start,
                                  autocorrect: true,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: Theme.of(context).colorScheme.onBackground,
                                      ),
                                  decoration: InputDecoration(
                                    hintText: 'Estoque',
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
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                            ),
                            SliverPadding(
                              padding: const EdgeInsets.fromLTRB(24, 16, 24, 48),
                              sliver: SliverToBoxAdapter(
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    buttonTheme: ButtonTheme.of(context).copyWith(
                                      alignedDropdown: true,
                                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                                    ),
                                  ),
                                  child: DropdownButtonFormField(
                                    elevation: 2,
                                    dropdownColor: Theme.of(context).colorScheme.surface,
                                    alignment: Alignment.centerLeft,
                                    decoration: InputDecoration(
                                      hintText: 'Categoria',
                                      hintStyle: TextStyle(
                                        color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      fillColor: Theme.of(context).colorScheme.onBackground.withOpacity(.05),
                                      filled: true,
                                      contentPadding: const EdgeInsets.fromLTRB(2, 22, 16, 22),
                                      alignLabelWithHint: true,
                                      isDense: true,
                                    ),
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          color: Theme.of(context).colorScheme.onBackground,
                                        ),
                                    value: categories.last.id,
                                    borderRadius: BorderRadius.circular(12),
                                    items: categories.map((category) {
                                      return DropdownMenuItem(
                                        value: category.id,
                                        onTap: () {
                                          _categoryId = category.id;
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 2),
                                          child: Text(
                                            category.name,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      _categoryId = value.toString();
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            _bloc.add(
                              AddProductStartedEvent(
                                name: _nameController.text,
                                description: _descriptionController.text,
                                price: int.tryParse(_priceController.text.replaceAll(RegExp(r'[R\$\.\,]'), '')) ?? 0,
                                categoryId: _categoryId,
                                stockQuantity: int.parse(_stockQuantityController.text),
                                sellerId: int.parse(widget.sellerId),
                              ),
                            );
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.onBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 22),
                            elevation: 0,
                          ),
                          child: Text(
                            'Cadastrar',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
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
                      const AppShimmerEffectComponent(),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
