import 'package:flutter/material.dart';

import 'widgets.dart';

class AppOutlinedSquaredIconButtonComponent extends StatelessWidget {
  final String icon;
  final Color? iconColor;
  final VoidCallback onPressed;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color? color;
  final Widget? leading;

  const AppOutlinedSquaredIconButtonComponent({
    super.key,
    required this.icon,
    this.iconColor,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
    this.color,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: OutlinedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();

          onPressed();
        },
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.square(56),
          maximumSize: const Size.square(56),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          side: BorderSide(
            color: color?.withOpacity(0.3) ?? Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
            width: 1,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          foregroundColor: color ?? Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
        ),
        child: AppSvgIconComponent(
          assetName: icon,
          color: iconColor ?? color ?? Theme.of(context).colorScheme.onBackground,
        ),
      ),
    );
  }
}
