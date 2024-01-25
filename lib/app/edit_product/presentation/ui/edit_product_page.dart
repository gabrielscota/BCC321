import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/widgets.dart';
import '../controller/edit_product_bloc.dart';

class EditProductPage extends StatefulWidget {
  final UniqueKey? heroKey;
  final Map product;

  const EditProductPage({super.key, this.heroKey, required this.product});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late final EditProductBloc _bloc;

  late final String _productId;

  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _priceController;
  late final TextEditingController _stockQuantityController;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<EditProductBloc>(context);

    _productId = widget.product['productId'];

    _nameController = TextEditingController(text: widget.product['name']);
    _descriptionController = TextEditingController(text: widget.product['description']);
    _priceController = TextEditingController(
      text: CurrencyFormat.formatCentsToReal(widget.product['price']),
    );
    _stockQuantityController = TextEditingController(text: widget.product['stockQuantity'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocConsumer<EditProductBloc, EditProductState>(
        listener: (context, state) {
          if (state is EditProductLoadingState) {
            showDialog(context: context, builder: (_) => const Center(child: CircularProgressIndicator()));
          } else if (state is EditProductSuccessfullState) {
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
                      assetName: AppIcons.edit,
                      size: 28,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Produto editado com sucesso!',
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
          } else if (state is EditProductErrorState) {
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
                                    assetName: AppIcons.edit,
                                    size: 48,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Edição do produto',
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
                                enabled: false,
                                readOnly: true,
                                controller: _nameController,
                                cursorHeight: 24,
                                textAlign: TextAlign.start,
                                autocorrect: true,
                                keyboardType: TextInputType.text,
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
                                  suffixIconConstraints: const BoxConstraints(maxHeight: 64, maxWidth: 64),
                                  suffixIcon: const Padding(
                                    padding: EdgeInsets.only(right: 16),
                                    child: AppSvgIconComponent(assetName: AppIcons.lock),
                                  ),
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
                                enabled: false,
                                readOnly: true,
                                controller: _priceController,
                                cursorHeight: 24,
                                textAlign: TextAlign.start,
                                autocorrect: true,
                                keyboardType: TextInputType.number,
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
                                  suffixIconConstraints: const BoxConstraints(maxHeight: 64, maxWidth: 64),
                                  suffixIcon: const Padding(
                                    padding: EdgeInsets.only(right: 16),
                                    child: AppSvgIconComponent(assetName: AppIcons.lock),
                                  ),
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
                            padding: const EdgeInsets.fromLTRB(24, 16, 24, 48),
                            sliver: SliverToBoxAdapter(
                              child: TextField(
                                controller: _stockQuantityController,
                                cursorHeight: 24,
                                textAlign: TextAlign.start,
                                autocorrect: true,
                                keyboardType: TextInputType.number,
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
                            EditProductStartedEvent(
                              productId: _productId,
                              description: _descriptionController.text,
                              stockQuantity: int.parse(_stockQuantityController.text),
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
                          'Salvar',
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
        },
      ),
    );
  }
}
