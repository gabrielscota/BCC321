import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSvgIconComponent extends StatelessWidget {
  final String assetName;
  final Color? color;

  const AppSvgIconComponent({
    super.key,
    required this.assetName,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      height: 24,
      width: 24,
      colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}
