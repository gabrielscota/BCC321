import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSvgIconComponent extends StatelessWidget {
  final String assetName;
  final Color? color;
  final double size;

  const AppSvgIconComponent({
    super.key,
    required this.assetName,
    this.size = 24.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      height: size,
      width: size,
      colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      alignment: Alignment.center,
    );
  }
}
