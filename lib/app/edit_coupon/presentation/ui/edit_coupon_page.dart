import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/widgets.dart';
import '../controller/edit_coupon_bloc.dart';

class EditCouponPage extends StatefulWidget {
  final UniqueKey? heroKey;
  final Map coupon;

  const EditCouponPage({super.key, this.heroKey, required this.coupon});

  @override
  State<EditCouponPage> createState() => _EditCouponPageState();
}

class _EditCouponPageState extends State<EditCouponPage> {
  late final EditCouponBloc _bloc;

  late final String _productId;

  late final TextEditingController _discountCodeController;
  late final TextEditingController _discountValueController;
  late final MaskTextInputFormatter _startDateFormatter;
  late final TextEditingController _startDateController;
  late final MaskTextInputFormatter _endDateFormatter;
  late final TextEditingController _endDateController;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<EditCouponBloc>(context);

    _productId = widget.coupon['couponId'];

    _discountCodeController = TextEditingController(text: widget.coupon['discountCode']);
    _discountValueController = TextEditingController(text: widget.coupon['discountValue'].toString());
    _startDateFormatter = MaskTextInputFormatter(mask: '##/##/####');
    _startDateController = TextEditingController(text: widget.coupon['startDate'] ?? '');
    _endDateFormatter = MaskTextInputFormatter(mask: '##/##/####');
    _endDateController = TextEditingController(text: widget.coupon['endDate'] ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocConsumer<EditCouponBloc, EditCouponState>(
        listener: (context, state) {
          if (state is EditCouponLoadingState) {
            showDialog(context: context, builder: (_) => const Center(child: CircularProgressIndicator()));
          } else if (state is EditCouponSuccessfullState) {
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
          } else if (state is EditCouponErrorState) {
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
                                    'Edição do cupom',
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
                                controller: _discountCodeController,
                                cursorHeight: 24,
                                textAlign: TextAlign.start,
                                autocorrect: true,
                                keyboardType: TextInputType.text,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.onBackground,
                                    ),
                                decoration: InputDecoration(
                                  hintText: 'Código do cupom',
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
                                controller: _discountValueController,
                                cursorHeight: 24,
                                textAlign: TextAlign.start,
                                autocorrect: true,
                                keyboardType: TextInputType.number,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.onBackground,
                                    ),
                                decoration: InputDecoration(
                                  hintText: 'Porcentagem de desconto',
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
                            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                            sliver: SliverToBoxAdapter(
                              child: TextField(
                                controller: _startDateController,
                                cursorHeight: 24,
                                textAlign: TextAlign.start,
                                autocorrect: true,
                                keyboardType: TextInputType.number,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.onBackground,
                                    ),
                                decoration: InputDecoration(
                                  hintText: 'Data de início',
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
                                  _startDateFormatter,
                                ],
                              ),
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.fromLTRB(24, 16, 24, 48),
                            sliver: SliverToBoxAdapter(
                              child: TextField(
                                controller: _endDateController,
                                cursorHeight: 24,
                                textAlign: TextAlign.start,
                                autocorrect: true,
                                keyboardType: TextInputType.number,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.onBackground,
                                    ),
                                decoration: InputDecoration(
                                  hintText: 'Data de término',
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
                                  _endDateFormatter,
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
                            EditCouponStartedEvent(
                              couponId: _productId,
                              discountCode: _discountCodeController.text,
                              discountValue: double.parse(_discountValueController.text),
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
